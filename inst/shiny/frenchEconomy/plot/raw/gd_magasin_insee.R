# https://insee.fr/fr/statistiques/4647413

library(insee)

Sys.setenv(INSEE_title_sep = " - | — | – ")

dtf = get_dataset_list()

idbank_list =
  get_idbank_list() %>%
  filter(str_detect(nomflow, "ICA-2015-EMAGSA")) %>%
  add_insee_title(lang = "fr")

idbank_selected = idbank_list %>% pull(idbank)

data =
  get_insee_idbank(idbank_selected) %>%
  split_title(lang = "fr")

ggplot(data, aes(x = DATE, y = OBS_VALUE)) +
  facet_wrap(~TITLE_FR2, scales = "free") +
  geom_line() +
  ggtitle("Chiffres d'affaires des enseignes de grande distribution en France")
