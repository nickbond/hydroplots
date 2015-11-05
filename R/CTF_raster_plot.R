#' Create a heatplot for flow and cease-to-flow periods in a daily time-series.
#'
#' @param df A dataframe with date in the first column (as character) and discharge
#'  in the second (can be modified with cols.
#' @param threshold The threshold used to indicate cease to flow.
#' @param units The units of the time series (used for the y-axis label).
#' @param format The date format used (default = '\%d/\%m/\%Y').
#' @param cols The columns of the Date and discharge fields (default = c(1,2)).
#' @return A ggplot object.
#' @examples
#' library(hydrostats)
#' data(Cooper)
#' ctf_heatmap(Cooper)
#'
#' data(Acheron)
#' df <- rbind(data.frame(River='Acheron', Acheron), data.frame(River='Cooper', Cooper))
#' ctf_plots <- dlply(df, .(River), function(x) ctf_heatmap(x, threshold=1000, cols=c(2,3)))
#' ctf_plots[[1]]
#' ctf_plots[[2]]
#' @export
ctf_heatmap <- function(df, threshold = 0, units = "ML/day", format = "%d/%m/%Y", cols = c(1, 2)) {
    df <- hydrostats::ts.format(df, cols = cols)
    df$Q <- ifelse(df$Q <= threshold, 0, df$Q)
    
    thrshld_lbl <- ifelse(threshold > 0, "Days below threshold", "Days CTF")
    leg_lbl <- ifelse(threshold > 0, "Flow above/below\n threshold", "Flow and\nCease-to-flow")
    
    df$x <- lubridate::year(df$Date)
    df$y <- lubridate::yday(df$Date)
    df$z <- ifelse(df$Q > threshold, 0, 1)
    
    df$z <- cumsum_reset(df$z) * -1
    dry.stats <- summary(df$z)
    Q.stats <- summary(df$Q[df$Q > 0])
    z.stats <- summary(df$z)
    z.min <- plyr::round_any(abs(z.stats[[1]]), 1)
    z.q1 <- plyr::round_any(abs(z.stats[[2]]), 1)
    z.q3 <- plyr::round_any(Q.stats[[5]], 10)
    z.max <- plyr::round_any(Q.stats[[6]], 10)
    
    df$z <- ifelse(df$z == 0, df$z, log10(df$z * -1) * -1)
    df$z <- ifelse(df$Q == 0, df$z, log10(df$Q + 1))
    df$z <- ifelse(df$z < 0, df$z * (max(df$z)/abs(min(df$z))), df$z)
    
    if (z.min == z.q1) {
        return("Error, no flows below the threshold")
    } else {
        
        p1 <- ggplot2::ggplot(df, aes(x = x, y = y, fill = z)) + geom_raster() + scale_fill_gradient2(name = leg_lbl, low = "red", mid = "white", high = "blue", labels = c(paste(z.min, thrshld_lbl), 
            paste(z.q1, thrshld_lbl), paste(threshold, units), paste(z.q3, units), paste(z.max, units))) + scale_y_continuous(limits = c(0, 365)) + labs(x = "Year", y = "Day of year")
        
        return(p1)
    }
}

cumsum_reset <- function(x, reset = 0) {
    out = x * ave(x, c(0L, cumsum(diff(x) != reset)), FUN = seq_along)
    return(out)
} 
