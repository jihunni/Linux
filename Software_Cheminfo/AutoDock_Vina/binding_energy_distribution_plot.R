library(readr)
library(ggplot2)

PostgreSQL_query_out = read_csv('PostgreSQL_query_out.csv')
PostgreSQL_query_out = lapply(PostgreSQL_query_out, as.numeric)
PostgreSQL_query_out = unlist(PostgreSQL_query_out)

# simple histogram
hist(PostgreSQL_query_out)

# histogram
plot_data = data.frame(PostgreSQL_query_out)
colnames(plot_data) = 'binding_affinity'
ggplot(plot_data, aes(x=binding_energy)) +
  geom_histogram(binwidth=.2, colour="black", fill="white") +
  geom_vline(aes(xintercept=mean(binding_energy, na.rm=T)),   # Ignore NA values for mean
             color="red", linetype="dashed", size=1) +
  ggtitle("Predicted binding energy with _____") +
  labs(x='binding affinity (kcal/mol)', y='the number of molecules')
