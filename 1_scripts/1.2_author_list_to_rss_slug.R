# loading libraries

library(tidyverse)

journalists <- as.data.frame(read_csv("data/journalists.csv", col_names = c("name"), col_types = c("c")))

journalists <- journalists %>% 
  mutate(name = str_replace_all(name, "á", "a"), 
         name = str_replace_all(name, "Á", "A"), 
         name = str_replace_all(name, "é", "e"), 
         name = str_replace_all(name, "É", "E"), 
         name = str_replace_all(name, "ű|ü|ú", "u"), 
         name = str_replace_all(name, "Ű|Ü|Ú", "u"), 
         name = str_replace_all(name, "í", "i"), 
         name = str_replace_all(name, "Í", "i"), 
         name = str_replace_all(name, "ó|ö|ő", "o"), 
         name = str_replace_all(name, "Ó|Ö|Ő", "O"), 
         name = str_to_lower(name), 
         name = str_replace_all(name, " ", "-"), 
         name = if_else(name == "merenyi-daniel", "grafitember", name)) 
  


write_rds(journalists, file = here::here("data", "rss_names.rds"))
