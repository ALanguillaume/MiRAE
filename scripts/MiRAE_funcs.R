##### Minimal Reproducible Analysis Example
##### Functions

#' Detect unique identifier columns
#'
#' Given a data.frame properly setup with units appended to measured variables,
#' this function will detect unique identifiers in the data.frame and return
#' a vector of 0 and 1s:
#'    - 0: column is NOT an unique identifier.
#'    - 1: column is an unique identifier.
#'
#' @param df A data.frame with with units appended to measured variables.
#' variable name and unit are separated by a dollar sign: variable$unit.
#'
#' @return An integer vector of 0 and 1 indicating if a given column
#' is a unique identifier or not.

detect_unique_ID <- function(df) {

  facts <- df[grep(".+\\$.+", names(df), invert = TRUE)]

  quants_names <- names(d)[!(names(d) %in% names(facts))]
  quants <- rep(0, length(quants_names))
  names(quants) <-  quants_names

  facts_is_ID <- purrr::map_int(facts, ~ dplyr::n_distinct(.x) == length(.x))

  int_ID <-  c(facts_is_ID, quants)
  int_ID <- int_ID[names(df)]

  return(int_ID)
}


#' ggplot2-based interaction plot
#'
#' Draw interaction plot using ggplot2. Return editable ggplot object.
#'
#' @param x.factor A column name from data in plain code not as a string,
#' indicating the variable to be mapped to the x axis.
#' @param trace.factor A column name from data in plain code not as a string,
#' indicating the variable whose levels will form the trace.
#' @param trace.factor A column name from data in plain code not as a string,
#' giving the response (y axis).
#' @data A data.frame containing the above mentioned variables.
#'
#' @return A ggplot object which can be stored a variable or edited using
#' ggplot2 functions.
#'

interaction_plot <- function(x.factor, trace.factor, response, data){

  load_packages <-  function(x) {
    suppressPackageStartupMessages(
      require(x, character.only = TRUE,quietly = TRUE)
    )}
  lapply(list("dplyr", "ggplot2", "rlang"), load_packages)


  x.factor <- enquo(x.factor)
  trace.factor <- enquo(trace.factor)
  response <- enquo(response)

  df <- data %>%
    group_by(!!x.factor, !!trace.factor) %>%
    summarise(Y = mean(!!response, na.rm = TRUE), .groups = "drop")
  p <- ggplot(df)+
    aes(x = !!x.factor, y = Y, group = !!trace.factor, colour = !!trace.factor)+
    geom_line()+
    geom_point()

  return(p)
}


#' Make pretty ANOVA table
#'
#'  Uses packages car and broom
#'
#' @param fit_lm A lm object (the results of fitting a linear model)
#'
#' @return A data.frame representing the ANOVA table for the linear model
#' provided, with a prettier formatting: decimal numbers rounded to 3 digits.

pretty_anova_table <- function(fit_lm){

  anova_fit <- car::Anova(fit_lm, type = "II")
  tidy_anova_fit <- broom::tidy(anova_fit)
  tidy_anova_fit <- purrr::modify_if(tidy_anova_fit,
                                     is.numeric,
                                     ~ round(.x, 3))
  return(tidy_anova_fit)

}
