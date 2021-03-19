# K-means Clustering 
# K Means Clustering is an unsupervised learning algorithm that tries to cluster data based on their similarity. Unsupervised learning means that there is no outcome to be predicted, and the algorithm just tries to find patterns in the data. In k means clustering, we have the specify the number of clusters we want the data to be grouped into. The algorithm randomly assigns each observation to a cluster, and finds the centroid of each cluster. Then, the algorithm iterates through two steps:

# Reassign data points to the cluster whose centroid is closest. Calculate new centroid of each cluster. These two steps are repeated till the within cluster variation cannot be reduced any further. The within cluster variation is calculated as the sum of the euclidean distance between the data points and their respective cluster centroids.

# Get the data
# The data set consists of 50 samples from each of three species of Iris (Iris setosa, Iris virginica and Iris versicolor). Four features were measured from each sample: the length and the width of the sepals and petals, in centimetres.
library(datasets)
print(head(iris))

library(ggplot2)
pl <- ggplot(iris, aes(Petal.Length, Petal.Width, color =Species )) + geom_point()
print(pl)

# Clustering 
# Now let's attempt to use the K-means algorithm to cluster the data. Remember that this is an unsupervised learning algorithm, meaning we won't give it any information on the correct labels:

set.seed(101)
# Luckily we already know how many clusters to expect
# kmeans(x, centers, iter.max = 10, nstart = 1,algorithm = c("Hartigan-Wong", "Lloyd", "Forgy", "MacQueen"), trace=FALSE)
irisCluster <- kmeans(iris[, 1:4], 3,nstart=20 )
print(irisCluster)

print(table(irisCluster$cluster, iris$Species))

# Cluster Visualizations
# We can plot the clusters out:
library(cluster)
cl.pl <- clusplot(iris, irisCluster$cluster, color = T, shade =T, label=0, lines=0)
print(cl.pl)

