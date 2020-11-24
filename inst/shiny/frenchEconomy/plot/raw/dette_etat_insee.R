
library(insee)
library(tidyverse)

idbank_list = get_idbank_list() %>%
  filter(str_detect(nomflow, "DETTE")) %>%
  add_insee_title(lang = "fr") %>%
  filter(dim3 == "S13") %>%
  filter(dim1 == "T") %>%
  filter(is.na(title4)) %>%
  filter(dim4 %in% c("F2", "F331", "F332", "F41", "F42"))

idbank_selected = idbank_list %>% pull(idbank)

data =
  get_insee_idbank(idbank_selected) %>%
  split_title(lang =" fr")

dette_tot = get_insee_idbank("010596744")

mycolors = c(brewer.pal(8, "Set1"), brewer.pal(8, "Set2"), brewer.pal(8, "Set3"))

ggplot() +
  geom_area(data = data, aes(x = DATE, y = OBS_VALUE, fill = TITLE_FR2)) +
  geom_line(data = dette_tot, aes(x = DATE, y = OBS_VALUE), size = 0.5) +
  geom_point(data = dette_tot, aes(x = DATE, y = OBS_VALUE)) +
  scale_fill_manual(values = mycolors) +
  ggtitle("Dette des administrations publiques") +
  labs(subtitle = sprintf("Dernier point : %s", max(data$DATE)))




