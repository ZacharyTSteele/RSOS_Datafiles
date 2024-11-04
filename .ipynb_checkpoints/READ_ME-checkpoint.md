{
 "cells": [
  {
   "cell_type": "markdown",
   "id": "9d78d92c",
   "metadata": {},
   "source": [
    "## Δ′17OBW  Model and Dataset \n",
    "\n",
    "We generated a model for estimating δ17OBW, δ18OBW, and Δ′17OBW by modifying and adjusting the model and code developed by Hu et al. (2023). The Hu et al. (2023) model was derived from the δ18OBW model developed by Kohn (1996), modifying this model to enable calculation of Δ′17OBW. For specific details of the differences between our model and the Hu et al. (2023), please see the methods section of the manuscript. \n",
    "\n",
    "This model estimates δ17OBW, δ18OBW, and Δ′17OBW using the following 30 parameters (in order of appearance in R code): \n",
    "Timeframe of turnover (Days)\n",
    "Animal body mass (kg)\n",
    "Fecal H2O content (%)\n",
    "Oxygen utilization fraction \n",
    "Z-value (‰)\n",
    "Animal body temperature (C) \n",
    "Meeh factor (proportionality constant - cm^2/kg^2/3) \n",
    "skin H2O evaporation rate (species specific constant - mg/cm^2/h/mm Hg)\n",
    "Inhaled oxygen (mL)\n",
    "Exhaled CO2 (mole)\n",
    "Relative humidity (%)\n",
    "Ambient Temperature (C)\n",
    "δ18O of meteoric water (‰)\n",
    "Δ′17O of meteoric water (per meg)\n",
    "δ18O of atmospheric oxygen (‰)\n",
    "Δ′17O of atmospheric oxygen (per meg)\n",
    "Food consumed (kg)\n",
    "Water intake (mL)\n",
    "Relative Digestibility (%)\n",
    "Drinker Nozzle Leakage (%)\n",
    "Energy extraction efficiency (%)\n",
    "Carbohydrate content of diet (% by mass)\n",
    "Fat content of diet (% by mass)\n",
    "Lipid content of diet (% by mass)\n",
    "Food associated H2O content (%)\n",
    "Fractional contribution from different food items\n",
    "δ17O of different food items \n",
    "δ18O of different food items\n",
    "Fractional contribution of different plant components of diet\n",
    "δ18O of different plant components of diet\n",
    "\n",
    "While there are 30 parameters in total, the majority of the parameters will be fixed for a specific study animal (e.g., skin H2O evaporation rate, Carbohydrate content, Fecal H2O content, etc.) and environment (ambient Temperature, δ18O of meteoric water\n",
    "Δ′17O of meteoric water, etc.). This leaves only a small amount of parameters that will change between individuals (e.g., animal body mass). In addition, the captive nature of our experiment resulted in several parameters being included that would otherwise be estimated using metabolic rate (e.g., food intake, inhaled oxygen, exhaled CO2) when studying free-ranging animals (see Hu et al. 2023).\n",
    "\n",
    "Only lines 13-71 of the code that contain the parameters should be adjusted. The rest of the code simply incorporates these parameters to calculate fractional contributions from the different oxygen fluxes, and then uses fractionation factors and exponents and absolute ratios (i.e., of meteoric water & atmospheric oxygen) to estimate δ17OBW, δ18OBW, and Δ′17OBW. \n",
    "\n",
    "The data that is provided in the 'ExperimentData' csv can be used to recreate all our predicted δ17OBW, δ18OBW, and Δ′17OBW values using the Δ′17OBW  Model code. This csv should be used in combination with the information presented in Tables 1 & 3 in the manuscript that cover the fixed parameters for the species and captive setting, and some of the parameters that changed between experimental manipulations. \n",
    "\n",
    "The 'ExperimentData' consists of seven columns relevant to the different sampling periods of the experiment: \n",
    "MouseID - The ID for the specific mouse in the experiment (1-8) \n",
    "Diet - If the mouse was consuming the control (0.49% NaCl) or 4% NaCl (experimental) diet. The diet consumed is also relevant to the timeframe of the code (if the mouse was eating the 4%NaCl diet, then the turnover will be shorter [2 days], whereas if the animal was eating the 0.49% NaCl diet the turnover will be longer [4 days]. \n",
    "Temp - What temperature (C) the mouse was housed at during that sampling (either 25, 18, or 15C). \n",
    "O2_Inhaled - The amount of O2 inhaled (mL) during the timeframe \n",
    "CO2_Exhaled - The amount of CO2 exhaled (mL) during the timeframe. This should be converted to moles by converting to L and then dividing by 22.4 \n",
    "Food_Consumed - The amount of food consumed (kg) during the timeframe \n",
    "Drinking_Water - The water intake (mL) during the timeframe \n",
    "Mass - The average body mass of the animal during the timeframe\n",
    "\n",
    "If you have any questions when using this code and/or data, please email Zach Steele (ZacharyTaylorSteele@gmail.com). "
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3 (ipykernel)",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython3",
   "version": "3.11.5"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
