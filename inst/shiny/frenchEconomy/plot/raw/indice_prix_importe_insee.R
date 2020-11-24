# https://insee.fr/fr/statistiques/4647413

library(insee)

Sys.setenv(INSEE_title_sep = " - | — | – ")

dtf = get_dataset_list()

idbank_list =
  get_idbank_list() %>%
  filter(str_detect(nomflow, "IPPMP")) %>%
  add_insee_title(lang = "fr") %>%
  filter(dim4 == "INDICE") %>%
  filter(dim5 == "FM") %>%
  filter(dim8 == "E")

idbank_selected = idbank_list %>% pull(idbank)

data =
  get_insee_idbank(idbank_selected) %>%
  split_title(lang = "fr")

ggplot(data, aes(x = DATE, y = OBS_VALUE)) +
  facet_wrap(~TITLE_FR2, scales = "free") +
  geom_line() +
  ggtitle("Indices des prix des matières premières importées en France")
