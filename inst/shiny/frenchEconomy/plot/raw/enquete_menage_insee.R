library(insee)
library(tidyverse)

idbank_list =
  get_idbank_list() %>%
  filter(str_detect(nomflow, "ENQ.*MENAGE")) %>%
  add_insee_title(lang = "fr") %>%
  filter(dim7 == "CVS")

idbank_selected = idbank_list %>% pull(idbank)

data =
  get_insee_idbank(idbank_selected) %>%
  split_title(lang = "fr") %>%
  filter(DATE >= "2010-01-01") %>%
  mutate(TITLE_FR2 = substr(TITLE_FR2, 1, 60))

ggplot(data, aes(x = DATE, y = OBS_VALUE)) +
  facet_wrap(~TITLE_FR2, scales = "free", ncol = 3) +
  geom_line() +
  ggthemes::theme_stata() +
  ggtitle("Enquêtes de conjoncture au près des ménages") +
  theme(axis.text.y  = element_text(angle = 0, hjust = 1))


