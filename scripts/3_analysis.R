##### Minimal Reproducible Analysis Example
##### 2 - analysis

##### Load data ------------------------------------------------------------------------------------

d <- read_excel(here("./data/processed/fertilizer_trial_WUR.xlsx"),
                sheet = "data")
# Replace unit separator $ => _
# $ is not a syntactic character in R
names(d) <- str_replace_all(names(d), "\\$", "_")

##### Analysis -------------------------------------------------------------------------------------


ggplot(d)+
  aes(x = fertilizer, y = yield_tha, colour = farm)+
  geom_point(na.rm = TRUE)+
  facet_wrap(farm ~ .)+
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))+
  ylim(0, 15)


interaction_plot(x.factor = farm,
                 trace.factor = fertilizer,
                 response = yield_tha,
                 data = d)+
  ylim(0, 15)


fit <- lm(yield_tha ~ farm + fertilizer, data = d)
fit %>% pretty_anova_table()


emms <- emmeans(fit,  pairwise ~  farm + fertilizer)

emms_df <- as.data.frame(emms$emmeans)

ggplot(d)+
  aes(x = fertilizer, y = yield_tha, colour = farm)+
  geom_point(na.rm = TRUE,
             position = position_dodge(width = 0.2),
             alpha = 0.2)+
  geom_pointrange(data = emms_df,
                  aes(y = emmean, ymin = lower.CL, ymax = upper.CL),
                  position = position_dodge(width = 0.2))+
  ylim(0, 15)
