# funzione: genera l'intervallo di confidenza ad un livello alpha
generate_ic <- function(alpha, pi_hat, n) {
    z_alphamezzi <- qnorm(1 - alpha/2)
    L <- pi_hat - z_alphamezzi * sqrt(pi_hat * (1 - pi_hat) / n)
    U <- pi_hat + z_alphamezzi * sqrt(pi_hat * (1 - pi_hat) / n)
    return(c(L, U))
}

# funzione: calcola l'actual coverage con pi e l'intervallo di confidenza
calculate_coverage <- function(ic, pi) {
    ris <- pi >= ic[, 1] & pi <= ic[, 2]
    actual_coverage <- mean(ris)
    return(actual_coverage)
}

run_simulation <- function(B, pi, n, alpha) {
    y <- replicate(B, rbinom(n, size = 1, pi))
    pi_hat <- colMeans(y)
    ic <- t(sapply(pi_hat, function(ph) generate_ic(alpha, ph, n)))

    # plot(pi_hat, main = paste("IC con pi =", pi, "e n =", n), xlab = "Simulazioni", ylab = "pi", pch = 20, col = "blue")
    # arrows(1:B, ic[, 1], 1:B, ic[, 2], angle = 90, code = 3, length = 0.05,
    #        col = ifelse(pi >= ic[, 1] & pi <= ic[, 2], "red", "purple"))
    # abline(h = pi, col = "green", lwd = 2)

    coverage <- calculate_coverage(ic, pi)
    print(paste("Actual coverage con pi =", pi, "e n =", n, ": ", coverage))

    # hist(pi_hat, main = paste("Distribuzione di pi_hat con pi =", pi, "e n =", n),
    #      xlab = "pi_hat", breaks = 20, col = "lightblue", border = "black")
}

# Definiamo gli scenari: eseguiamo la simulazione con diverse combinazioni di parametri
combinations <- list(
    list(B = 1000, pi = 0.1, n = 50, alpha = 0.05),
    list(B = 1000, pi = 0.1, n = 500, alpha = 0.05),
    list(B = 1000, pi = 0.1, n = 1000, alpha = 0.05),
    list(B = 1000, pi = 0.5, n = 50, alpha = 0.05),
    list(B = 1000, pi = 0.5, n = 500, alpha = 0.05),
    list(B = 1000, pi = 0.5, n = 1000, alpha = 0.05),
    list(B = 1000, pi = 0.7, n = 50, alpha = 0.05),
    list(B = 1000, pi = 0.7, n = 500, alpha = 0.05),
    list(B = 1000, pi = 0.7, n = 1000, alpha = 0.05),
    list(B = 50, pi = 0.9, n = 1000, alpha = 0.05) # B=50 per visualizzare in maniera più chiara gli intervalli di confidenza
)

set.seed(111);

lapply(combinations, function(params) {
    run_simulation(params$B, params$pi, params$n, params$alpha)
})