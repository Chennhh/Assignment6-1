library(ggmap)
library(tidyverse)
library(magick)

gc <- geocode("Bude")
Budepath <- get_map("Bude North Cornwall Cricket Club,Bude", zoom = 8)
Wbude<- get_map(gc,source ="stamen",maptype ="watercolor",zoom = 13,crop=FALSE)
Rbude <-get_googlemap(center = c(lon = -4.543678, lat = 50.82664),maptype ="roadmap",zoom = 14)
gc1 <- geocode("Bude Sea Pool,bude")
gc2 <- geocode("Bude Beaches,bude")
gc3 <- geocode("Bude North Cornwall Cricket Club,bude")
gc4 <- geocode("Bar 35,bude")

#merge both rows#
geocomb <- rbind(gc1,gc2,gc3)%>% 
  mutate(location = c('Bude Sea Pool','Sandymouth Beach','Bude North Cornwall Cricket Club'),values=30)
geopath <- rbind(gc3,gc4)%>% 
  mutate(location = c('Bude North Cornwall Cricket Club','Bar 35'))

#Watermap#
watermap <- ggmap(Wbude) +
  geom_point(data = geocomb,
             aes(x = lon, y = lat, size=location),
             color = "red") 

watermap

########### hw 
############## you can save the map as an image like this:
dev.copy(png,'watermap.png')
dev.off()

## or

## you can save the map as data like this:
saveRDS(watermap, "watermap.RDS")

### in the Rmd file I'll load the map using both methods



#Roadmap#
roadmap <- ggmap(Rbude) +
  geom_point(
    aes(x = lon, y = lat ),
    data = geocomb, color = "red", size = 3)+
  geom_path(
    aes(x = lon, y = lat), colour = "red", size = 1.5,
    data = geopath, lineend = "round")

roadmap

#### Same as above
dev.copy(png,'roadmap.png')
dev.off()

### or

saveRDS(roadmap, "roadmap.RDS")

#images of bude Bude Beaches#
BudeBeaches <- image_scale(image_read('https://www.visitbude.info/wp-content/uploads/2015/04/Black-Rock-Beach.jpg'),geometry_area(400,400))
print(BudeBeaches)

image_write(BudeBeaches, path = "BudeBeaches.jpg", format = "jpg")

#Images of Bude Sea Pool#
BudeSeaPool <- image_scale(image_read('https://www.visitengland.com/sites/default/files/styles/experience_page_consumer_gallery_image/public/bude_sea_pool_-_credit_rob_keir.jpg?itok=gDX730Ss'),geometry_area(400,400))
print(BudeSeaPool)

image_write(BudeSeaPool, "BudeSeaPool.jpg", format="jpg")

#Images of Sandymouth Beach
SandymouthBeach <- image_scale(image_read('http://www.beachesincornwall.co.uk/wp-content/uploads/2017/04/bude-sandymouth.jpg'),geometry_area(400,400))
print(SandymouthBeach)

image_write(SandymouthBeach, "SandymouthBeach.jpg", format="jpg")

#Images of Bude North Cornwall Cricket Club#
Budecricket <- image_scale(image_read('https://www.telegraph.co.uk/content/dam/Travel/galleries/travel/destinations/europe/uk/Englands-most-beautiful-cricket-grounds/cricket-bude_3378037a.jpg?imwidth=1400'),geometry_area(400,400))
print(Budecricket)

image_write(Budecricket, "Budecricket.jpg", format = "jpg")

