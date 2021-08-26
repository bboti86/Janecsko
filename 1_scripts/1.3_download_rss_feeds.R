# loading libraries

library(tidyverse)
library(tidyRSS)
library(glue)
library(tidyRSS)

# reading slugs

rss_author_slugs <- read_rds(here::here("data","rss_names.rds"))

# creating RSS URLS

url <- 'https://telex.hu/rss/archivum?filters={{"authorSlugs":["{name}"],"parentId":["null"]}}'

urls <- rss_author_slugs %>%
  mutate(url = glue(url)) %>%
  mutate(url = URLencode(url))



feeds <- tibble()


for (u in 1:nrow(urls)) {
  tryCatch(
  {feeds <- bind_rows(feeds, 
                      tidyfeed(urls$url[u])%>%mutate(name=urls$name[u]))
  }, error=function(e){})
   message(u, ":", urls$name[u]) 
  Sys.sleep(0.3)
}

