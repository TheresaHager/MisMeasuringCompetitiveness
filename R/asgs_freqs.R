library(data.table)
library(here)
library(tidyverse)
library(icaeDesign)
count_data_file <- here("data/tidy/asgs_freqs_2011-2021.csv")
# Relative frequency of words--------------------------------------------------
word_nb <- 30 # The number of words to be plotted
filtered_words <- c("%", "•", "``", "Œ") # Words to be filtered out
word_freqs <- fread(count_data_file) %>%
  filter(!words %in% c(filtered_words)) %>%
  group_by(year) %>% 
  slice_max(order_by = freqs, n = word_nb) %>%
  ungroup()

#' Function to create the plot for a single year
make_freq_plot <- function(word_data, year_cons){
  ggplot(
      data = dplyr::filter(word_data, year==year_cons), 
      aes(x=reorder(words, -freqs), y=freqs)
    ) +
    geom_bar(
      stat = "identity", 
      color=NA, 
      fill=viridis::cividis(1), 
      alpha=0.75) +
    labs(title = as.character(year_cons)) +
    scale_y_continuous(
      expand = expansion(), 
      labels = scales::percent_format(scale = 1)) +
    theme_icae() +
    theme(axis.text.x = element_text(
      angle = 90, hjust = 1, vjust = 1), 
      panel.grid.major.x = element_blank(), 
      panel.grid.minor.x = element_blank(),
      axis.title = element_blank())
}

plot_list <- list()
for (y in unique(word_freqs$year)){
  print(y)
  plot_list[[as.character(y)]] <- make_freq_plot(word_freqs, y)
}

full_plot <- ggpubr::ggarrange(
  plotlist = plot_list, ncol = 4, nrow = 3)

full_plot <- ggpubr::annotate_figure(
  full_plot,
  top = ggpubr::text_grob(
    label = "Most frequent words in the ASGS", size = 16), 
  left = ggpubr::text_grob(
    label = "Relative frequency", size = 14, rot=90))

ggsave(plot = full_plot, 
       filename = here("output/most_freq_words.pdf"), 
       width = 14, height = 7)

# Share of interesting words---------------------------------------------------

#' Create freq table for given word stems
#' @param data_used Tibble with word count data
#' @param work_stems Vector with word stems
#' @return data.table with relative frequency of words starting with the word stems
get_stem_freq <- function(data_used, word_stems){
  get_freq <- function(dat, st){
    dat %>%
      filter(str_starts(words, st)) %>%
      mutate(words = paste0(st, "*")) %>%
      group_by(year, words) %>%
      summarise(freqs = sum(freqs), .groups = "drop")
  }
  freq_list <- purrr::map(
    .x = word_stems, 
    .f = ~get_freq(dat = word_freqs_2_data, st = .))
  data.table::rbindlist(freq_list)
}

# Because they form traditionally the core of the ASGS we we include the terms
# *growth*, *investment*, and *jobs*, and due to its recent relevance in the 
# discourse also *sustainable*/*sustainability*. These terms will serve as a 
# reference point to judge the relative importance of terms related to 
# *competition* and *competitiveness*/*competitive*.
# To put the topic of 'competitiveness' into relation to the overall promise of 
# economic convergence, we also taking into account the words *convergence* and 
# *cohesion*, which seem to be used interchangeably. 

words_of_interest <- c(
  "growth", "investment", "jobs", "employment",
  "convergence", "cohesion")

# Also use the following word stems 
word_stems_of_interest <- c("sustainab", "competiti")

# In Python folgende Kombinationen ergänzen:
# "sustainab" in Kombination mit "financ" innerhalb von einem Satz? 
# competitive sustainability

word_freqs_2_data <- fread(
  count_data_file, 
  select = c("words"="character", "freqs"="double", "year"="factor")) %>%
  filter(
    !words %in% c(filtered_words), 
    !substr(words, 1, 1) %in% c(filtered_words, c("-", "+", "'", "/", "_")),
    !str_starts(words, "\\d"),
    nchar(words)>2) %>%
  mutate(
    words = stringr::str_to_lower(words), # make everything lowercase
    # Consider synonymous words:
    words = ifelse(words %in% c("jobs", "employment"), "jobs/employment", words),
    words = ifelse(words %in% c("convergence", "cohesion"), "convergence/cohesion", words)
  ) %>%
  group_by(words, year) %>%
  summarise(freqs = sum(freqs), .groups = "drop")

# First extract word stems
word_freqs_2_stems <- get_stem_freq(
  data_used = word_freqs_2_data, word_stems = word_stems_of_interest)

word_freqs_2 <- word_freqs_2_data %>%
  filter(words %in% c(words_of_interest, 
                      "jobs/employment", "convergence/cohesion")) %>%
  rbind(word_freqs_2_stems) %>%
  mutate(words_lab = ifelse(
    words=="jobs/employment", "jobs/emp.", 
    ifelse(words=="convergence/cohesion", "conv./coh.", words)))

word_freqs_2_bar <- ggplot(
  word_freqs_2, aes(x = reorder(words, -freqs), y=freqs, fill=year)) +
  geom_bar(
    stat = "identity",
    position = position_dodge2(),
    color=NA, 
    alpha=0.75) +
  labs(title = "Frequency of selected words", y="Relative frequency") +
  scale_fill_viridis_d(option = "E", guide = guide_legend(ncol = 6)) +
  scale_y_continuous(
    expand = expansion(), 
    labels = scales::percent_format(scale = 1)) +
  theme_icae() +
  theme(
    axis.title.y = element_text(size=13),
    axis.title.x = element_blank(),
    axis.text = element_text(size=12),
    plot.title = element_text(size=14),
    legend.text = element_text(size=13),
    panel.grid.major.x = element_blank(), 
    panel.grid.minor.x = element_blank()
    )

ggsave(plot = word_freqs_2_bar, 
       filename = here("output/freq_select_words.pdf"), 
       width = 9, height = 3)

word_freqs_2_line <- ggplot(
  word_freqs_2, aes(x = year, y=freqs, color=words, group=words)) +
  geom_line(alpha=0.2, key_glyph=draw_key_rect) + geom_point(alpha=0.2, key_glyph=draw_key_rect) + 
  geom_smooth(formula = "y ~ x", method = "loess", se = FALSE) +
  ggrepel::geom_label_repel(
    data = filter(word_freqs_2, year==2011), 
    mapping = aes(label=words_lab), nudge_x = -3, 
    show.legend = FALSE, max.iter = 10000, force = 6, seed = 123) +
  ggrepel::geom_label_repel(
    data = filter(word_freqs_2, year==2021), 
    mapping = aes(label=words_lab), nudge_x = 3, show.legend = FALSE,
    max.iter = 10000, force = 4, seed = 123) +
  labs(title = "Frequency of selected words", y="Relative frequency") +
  scale_color_brewer(palette = "Dark2") +
  # scale_color_viridis_d(option = "E", guide = guide_legend(ncol = 5)) +
  scale_y_continuous(
    #expand = expansion(), 
    labels = scales::percent_format(scale = 1, accuracy = 0.1)) +
  scale_x_discrete(expand = expansion(add = 3)) +
  theme_icae() +
  theme(
    axis.title.y = element_text(size=13),
    axis.title.x = element_blank(),
    axis.text = element_text(size=12),
    plot.title = element_text(size=14),
    legend.text = element_text(size=13),
    panel.grid.major.x = element_blank(), 
    panel.grid.minor.x = element_blank()
  )

ggsave(plot = word_freqs_2_line, 
       filename = here("output/freq_select_words_lines.pdf"), 
       width = 8, height = 4.5)

