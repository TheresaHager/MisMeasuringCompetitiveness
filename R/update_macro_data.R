# Updates comp_macro.rds using the competitivenessDataR package
library(here)
macro_old <- readRDS(here("data/tidy/comp_macro.rds"))
macro_new <- competitivenessData::competitiveness_data_macro
old_vars <- names(macro_old)
new_vars <- names(macro_new)
added_vars <- setdiff(new_vars, old_vars)
removed_vars <- setdiff(old_vars, new_vars)

cat("Updated comp_macro. The following variables were removed: \n")
cat(removed_vars)
cat("The following variables were added: \n")
cat(added_vars)

saveRDS(macro_new, here::here("data/tidy/comp_macro.rds"))
