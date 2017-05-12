##Grailed Challenge

### To run

- `git clone https://github.com/jaycanty/GrailedChallenge.git`
- `cd GrailedChallenge`
- `open GrailedChallenge.xcworkspace`
- run (Pods are checked in)

### Shortcommings/Things I should have asked

- I used a reference cell to figure variable heights for the collection view. Bit hacky, it seems to work ok.
- The 'cover_photo' is huge, for every cell.  I should have asked if there is a way to scale images on your CDN.  
- There may be a bug in the 'cover_photo' metadata.  My hunch is, width/height gets switched sometimes. 
- Image caching is much too simple.
- My search is the most basic, items are not sorted by date. Should have asked a bit about Algolia.  

### 3rd party

- AlgoliaSearch-Client-Swift