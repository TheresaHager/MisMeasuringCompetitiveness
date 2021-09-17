# Get export shares and ECI values from Atalas data

load(here("data/raw/country_sitcproductsection_year.RData"))

country_list <- unique(macro_data$iso3c)
year_list <- unique(macro_data$year)

comp_data <- table %>%
  dplyr::filter(
    year >= min(year_list, na.rm = T),
    year <= max(year_list, na.rm = T)
    ) 

eci_ranks <- comp_data %>%
  dplyr::select(
    dplyr::all_of(c("location_code", "year", "sitc_eci"))
  ) %>%
  dplyr::distinct(year, location_code, .keep_all = T) %>%
  group_by(year) %>%
  mutate(eci_rank=rank(-sitc_eci, ties.method = "min")) %>%
  ungroup() %>%
  dplyr::filter(
    location_code %in% country_list
  )  %>%
  dplyr::select(
    dplyr::all_of(c("location_code", "year", "eci_rank"))
  )
  
eci_values <- comp_data %>%
  dplyr::filter(
    location_code %in% country_list
  ) %>%
  dplyr::left_join(., eci_ranks, by=c("location_code", "year")) %>%
  dplyr::select(
    dplyr::all_of(c("location_code", "year", "sitc_eci", "eci_rank"))
  ) %>%
  dplyr::distinct(year, location_code, .keep_all = T)

exp_shares <- comp_data %>%
  dplyr::select(dplyr::all_of(
    c("product_id", "year", "export_value", "location_code"))
  ) %>%
  group_by(year) %>%
  dplyr::mutate(
    world_exports = sum(export_value, na.rm = T)
  ) %>%
  ungroup() %>%
  group_by(location_code, year) %>%
  dplyr::mutate(
    country_exports = sum(export_value, na.rm = T)
  ) %>%
  dplyr::mutate(
    world_mkt_share = country_exports / world_exports
  ) %>%
  dplyr::select(-product_id) %>%
  dplyr::distinct(year, location_code, .keep_all = T) %>%
  group_by(year) %>%
  mutate(
    test_share = sum(world_mkt_share)
    ) %>%
  ungroup() %>%
  dplyr::select(
    dplyr::all_of(
      c("location_code", "year", "world_mkt_share", "country_exports"))
  ) %>%
  dplyr::filter(
    location_code %in% country_list
  )

final_frame <- dplyr::left_join(
  exp_shares, eci_values, 
  by=c("location_code", "year")
  ) %>%
  dplyr::rename(iso3c=location_code)

data.table::fwrite(
  final_frame, file = here::here("data/tidy/export_eci.csv"))
