library("tidyverse")
library("bayestestR")
library("rdflib")

set.seed(212)

data <- simulate_simpson(n = 10, groups = 3, r = 0.5, group_prefix = "reg_")
names(data) <- c("x", "y", "reg")

data_triples <- data |>
  rowid_to_column("subject") |>
  mutate(subject = paste0("patient_", subject)) |>
  group_split(reg) |>
  lapply(function(d) {
    d |>
      select(-reg)
  })

data_rdf <- lapply(data_triples, function(d) { as_rdf(d, key_column = "subject", prefix = "fairvasc")})

for(reg in 1:length(data_rdf)) {
  rdf_serialize(data_rdf[[reg]], paste0("reg",reg,".n3"), format = "nquads")
}

for(registry in data$reg) {
  xtx <- crossprod(cbind(1, as.matrix(data |> filter(reg == registry) |> select(x))))
  xty <- crossprod(cbind(1, as.matrix(data |> filter(reg == registry) |> select(x))), as.matrix(data |> filter(reg == registry) |> pull(y)))
  write.table(xtx, paste0(registry, "_xtx.csv"), sep = ", ", row.names = FALSE, col.names = FALSE)
  write.table(xty, paste0(registry, "_xty.csv"), sep = ", ", row.names = FALSE, col.names = FALSE)
  sink(paste0(registry, "_betas.txt"))
  print(lm(y~x, data |> filter(reg == registry)))
  sink()
}
xtx <- crossprod(cbind(1, as.matrix(data |> select(x))))
xty <- crossprod(cbind(1, as.matrix(data |> select(x))), as.matrix(data |> pull(y)))
write.table(xtx, "reg_all_xtx.csv", sep = ", ", row.names = FALSE, col.names = FALSE)
write.table(xty, "reg_all_xty.csv", sep = ", ", row.names = FALSE, col.names = FALSE)
sink("reg_all_betas.txt")
print(lm(y~x, data))
sink()
