library(data.table)
library(here)
library(tidyverse)
library(icaeDesign)
bgs_count_data_file <- here("data/tidy/asgs_freqs_2011-2021_bgs.csv")
# Relative frequency of words--------------------------------------------------
word_nb <- 30 # The number of words to be plotted
filtered_words <- c("%", "•", "``", "Œ") # Words to be filtered out
bgs_freqs <- fread(bgs_count_data_file) 


bgs_freqs %>%
  filter(substr(bigrams, 1, 12)=="competitive_") 

bgs_freqs %>%
  filter(substr(bigrams, 1, 10)=="financ_sus") 

word_freqs%>%
  filter(substr(words, 1, 11)=="sustainabil") 


bgs_freqs %>%
  filter(substr(bigrams, 1, 14)=="sustainab_comp") 

%>%
  group_by(year) %>% 
  slice_max(order_by = freqs, n = word_nb) %>%
  ungroup()


count_data_file <- here("data/tidy/asgs_freqs_2011-2021.csv")

filtered_words <- c("%", "•", "``", "Œ") # Words to be filtered out
word_freqs <- fread(count_data_file) %>%
  filter(!words %in% c(filtered_words)) %>%
  group_by(year) %>% 
  slice_max(order_by = freqs, n = word_nb) %>%
  ungroup()