MAIN=$(ps2ascii MisMeasuringCompetition.pdf | wc -w)
APP=$(ps2ascii MisMeasuringCompetition-Appendix.pdf | wc -w)
echo "Words in main text: $MAIN"
echo "Words in appendix: $APP"