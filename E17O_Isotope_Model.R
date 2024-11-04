## alpha1 and alpha 2 are functions needed for calculating fractionation factors 
## please see Majoube 1971; Friedman & O’Neil 1977;O’Neil & Adami 1969
alpha1<-function(x){
  a1<-exp((1.137*10^6/(x^2)-4.156*10^2/x-2.0667)/1000)
  return(a1)}

exp((1.137*10^6/(288.15^2)-4.156*10^2/188.15-2.0667)/1000)

alpha2<-function (x) {
a2<-exp((1.66*10^4/x-15.69)/1000)
return(a2)}

# Animal-Specific Parameters
Days<-4                     # Number of days assumed for water turnover
Mass<-0.0193                # Animal Mass (kg)
FecalH2O<- 0.55             # Fecal H2O content (%)
Frac_used_O2<- 0.25         # Fraction of O2 used *oxygen utilization fractions (Rezende et al. 2004)
Z_value<- 10.5              # Z-value *Kohn 1996 - see Zanconato et al. 1992
Body_T<- 38+273.15          # Body temperature (K)
Temp<- 38                   # Body temperature (C)
meeh_factor<-1100           # Proportionality constant known as the Meeh factor (According to Dawson and Hulbert [1970] 
                            # k is often assumed to be ~ 1000, and has values of 1100-1200 for a variety of marsupials)
Skin_evap_constant<-0.025   # taxa-specific skin H2O evaporation rate (see Schmidt-Nielsen 1969)
O2_resp_2<-5582             # Total amount of O2 consumed (mL)
CO2<-  0.21417              # CO2 loss (moles)

# Environmental Parameters
rh<- 0.45                   # Relative humidity
T<- 273.15+ 25              # Environment temperature (K)
T_c<-25                     # Environment temperature (C)
d18O_mw<- -4                # Meteoric water [pre-formed water] d18O composition (per mil)
D17O_mw<- 0.020             # Meteoric water D17O composition (per mil)
d18O_atmO2<- 24.046         # Atmospheric O2 d18O composition (Wostbrock et al. 2020)
D17O_atmO2<- -0.441         # Atmospheric O2 D17O composition (Wostbrock et al. 2020)

# Food Parameters
Food_consumed<-0.01297      # Total consumed food (kg)
Drinking<-10.44             # Unadjusted drinking water  (mL)
Digest<- 0.85               # Relative Digestibility (see Kohn 1996 or Robbins 1983)
Leakage<-0.10               # Estimated percent of drinker nozzle leakage
Energy_effi<- 1             # Energy extraction efficiency (see Robbins 1983)
Carb_content<- 0.672        # Food carbon content (From mice diet)
Fat_content<- 0.074         # Food fat content (From mice diet)
Protein_content<- 0.254     # Food protein content (From mice diet)
H2Oassoc_content<- 0.09     # Food associated H2O content (Estimate provided by company that made mice diet [Teklad])

#Fractional contribution from different food items (add more as needed)#
FoodItem_1_f<-1
FoodItem_2_f<-0
FoodItem_3_f<-0
FoodItem_4_f<-0
FoodItem_5_f<-0

#Isotope composition of different food items (add more as needed)#
FoodItem_1_d17O<- -8.67
FoodItem_1_d18O<- -16.41
FoodItem_2_d17O<-0
FoodItem_2_d18O<-0
FoodItem_3_d17O<-0
FoodItem_3_d18O<-0
FoodItem_4_d17O<-0
FoodItem_4_d18O<-0
FoodItem_5_d17O<-0
FoodItem_5_d18O<-0

# Estimated cellulose composition of different plant components of mice diet#
Cellulose_1_f<-0.43
Cellulose_2_f<-0.37
Cellulose_3_f<-0.20
#Estimated d18O isotope composition of different plant components of mice diet using Roden & Ehleringer 2000#
d18O_Cellulose_1<-26
d18O_Cellulose_2<-26.9
d18O_Cellulose_3<-25.9

######### Do not Change Anything after this line ###############
  
#         Constants         #

lamda<- 0.528              # Reference lamda value for water system
R_18_SMOW<- 0.0020052       # O-18 isotope ratio, standard SMOW
R_17_SMOW<- 0.00038         # O-17 isotope ratio, standard SMOW

# Ingested Food # 
Food_O2<- Carb_content*11.12
# Moles of O per kg food (mole/kg)
Food_CO2_02<- Carb_content*11.12+Fat_content*2+Protein_content*3
# Moles of O2 from CO2 per kg food (mole/kg)
Condensation_Rxn_H2O<- Food_consumed*Food_O2*Digest*Energy_effi                            
# Food oxygen content ingested (mole) 
Food_CO2_O2_content<- Food_consumed*Food_CO2_02*Digest*Energy_effi
# Food O2 content from CO2 ingested (mole) 
Decarboxylation_Ox<-Food_CO2_O2_content*2
# Food O content from CO2 ingested (mole)
Food_H2O<- Food_consumed*55.56/(1-H2Oassoc_content)*H2Oassoc_content
# Influx of unbound food H2O - 55.6 is the mole of ingested free food water

# Oxidase Water #
resp_Atoms_O<-O2_resp_2*(5.38*10^19)
# Total atoms of oxygen consumed (see Whiteman et al. 2019)
Oxidase_H2O<-resp_Atoms_O/(6.023*10^23)
# Total moles of oxygen consumed (see Whiteman et al. 2019) 

# Atmospheric O2 #
O2_resp<- Oxidase_H2O/2
# O2 respired (mol)

# Atmospheric H2O #
Air_ex<- O2_resp/Frac_used_O2/0.21*22.4
# Amount of air fluxed through the lungs (L)
H2O_sat_content<-10^(0.686+0.027*(T-273.15))/760/22.4
# Saturation concentration of H2O in air at ambient temperature (mole/L)
Air_H2O<- rh*H2O_sat_content*Air_ex
# Amount of H2O from atmosphere (mole)

# Drinking H2O #
Leak_Value<-1-Leakage
# Calculation of leakage adjustment value
Drinking_Adjusted<-Leak_Value*Drinking
# Adjusted drinking water value (mL)
Drinking_H2O<-Drinking_Adjusted/18
# Adjusted drinking water value (mole)
T_in<-Condensation_Rxn_H2O+Oxidase_H2O+Air_H2O+Food_H2O+Drinking_H2O+Decarboxylation_Ox
# Total inputs (mole)

#    Output    #

Breath_H2O<-Air_ex*10^(0.686+0.027*Temp)/760/22.4
# Exhaled water vapor from breathing (mole)
Oral_H2O_breath<-Breath_H2O/2      
# Oral water loss through breathing                           
M_Fecal<-Food_consumed*(1-Digest)
# Dry fecal output (kg)
Fecal_O2<-0                 
# Fecal O2 content (mole)
Fecal_H2O<-M_Fecal/(1-FecalH2O)*FecalH2O*55.56
# Fecal H2O content calculated from dry fecal output (mole)
Food_urea<- 6*Food_consumed*Protein_content*Digest*Energy_effi  
# Mole of Urea or Uric acid (mole)
Urea_O2<-Food_urea/2        
# Urea/ureic acid O2 content (mole)
Nasal_H2O<- Breath_H2O/4    
# Nasal water vapor loss (mole)
Vapor_Pressure_Deficit<-((610.78*exp((T_c/(T_c+237.3)*17.2694))/1000)*(1-(rh)))
#kilopascals; For calculation of transcuatenous water vapor loss (Schmidt-Nielsen 1969)
Vapor_Pressure_Deficit_mmHg<-Vapor_Pressure_Deficit*(760/101.325) 
#convert Vapor_Pressure_Deficit to mmHg
Skin_Vap<-Vapor_Pressure_Deficit_mmHg*Skin_evap_constant
# Multiply by taxa specific skin H2O evaporation constant
Perm<-(meeh_factor*Skin_Vap/1000)*24/18 
# Skin permeability factor calculated from Skin_Vap and meeh factor
Skin_H2O<- Perm*Mass^(2/3)*Days
# Transcutaneous water vapor loss (mole)
RQ<- CO2/O2_resp             
# CO2/O2 ratio  
Oral_H2O<-Oral_H2O_breath     
# Total oral water loss
Urine<- T_in-Fecal_H2O-Nasal_H2O-Skin_H2O-Oral_H2O-CO2*2-Urea_O2*2
# Urinary water loss (mole) is assumed to be remaining residual
T_out<- Fecal_H2O+Urea_O2*2+Urine+Nasal_H2O+Skin_H2O+Oral_H2O+CO2*2
# Total oxygen output (mole)

# Input fractions #
ffo<- Condensation_Rxn_H2O/T_in       # Fraction of condensation water
ffp<-Food_H2O/T_in                    # Fraction of food water
fO2<- Oxidase_H2O/T_in                # Fraction of oxidase water
fvap<- Air_H2O/T_in                   # Fraction of inhaled water vapor
fdw<- Drinking_H2O/T_in               # Fraction of drinking water
fCO_in<-Decarboxylation_Ox/T_in       # Fraction of decarboxylation oxygen
F_in<- ffo+fO2+fvap+fdw+ffp+fCO_in    # Total input flux (=1)

# Output fractions #
ffecO<- Fecal_O2/T_out                # Fraction of fecal O2
ffec<- Fecal_H2O/T_out                # Fraction of fecal water loss
furO<- 2*Urea_O2/T_out                # Fraction of oxygen loss in urea
fur<- Urine/T_out                     # Fraction of urinary water loss
fnas<- Nasal_H2O/T_out                # Fraction of nasal water vapor loss
ftrans<- Skin_H2O/T_out               # Fraction of transcutaenous water vapor loss
foral<- Oral_H2O/T_out                # Fraction of oral water vapor loss
fCO2<- CO2*2/T_out                    # Fraction of exhaled CO2
F_out<- ffecO+ffec+furO+fur+fnas+ftrans+foral+fCO2
# Total output flux (=1)

# Fractionation factors and exponents (modified from Hu et al. 2023) #

# Fractionation Factors #

# Input #
# Fractionation factors between atmospheric H2O vapor and meteoric water (mw)
a_vap_mw_18<-1/alpha1(T)                                                      
# alpha_18O
l_vap_mw<-0.529                                                             
# fractionation exponent between water vapor and liquid water (Barkan & Luz 2005)
a_vap_mw_17<-exp(l_vap_mw*log(a_vap_mw_18))                                   
# alpha_17O

# Fractionation factors between drinking water and mw                            
a_dw_mw_18<-1                                       
# alpha_18O
a_dw_mw_17<-1                                      
# alpha_17O

# Fractionation factors for atmospheric O2
a_in_O2_18<- (1000+(d18O_atmO2-Z_value)/(1-Frac_used_O2))/(1000+d18O_atmO2)   
# alpha_18O
l_in_O2<- 0.5179                                   
# Fractionation exponent between lung-absorbed O2 and atm.O2, (Luz & Barkan 2005)
a_in_O2_17<- exp(l_in_O2*log(a_in_O2_18))          
# alpha_17O

# Fractionation factors between mouse diet plant component 1 cellulose and mw 
a_cell_1_mw_18<-(1000+d18O_Cellulose_1)/(1000+d18O_mw)  
# alpha_18O
l_cell_mw<- 0.525                                 
# Fractionation exponent bewteen cellulose and meteoric water (lower end of Pack et al. 2013)
a_cell_1_mw_17<- exp(l_cell_mw*log(a_cell_1_mw_18))     
# alpha_17O

# Fractionation factors between mouse diet plant component 2 cellulose and mw 
a_cell_2_mw_18<-(1000+d18O_Cellulose_2)/(1000+d18O_mw)   
# alpha_18O                                  
a_cell_2_mw_17<- exp(l_cell_mw*log(a_cell_2_mw_18))     
# alpha_17O

# Fractionation factors between mouse diet plant component 2 cellulose and mw 
a_cell_3_mw_18<-(1000+d18O_Cellulose_3)/(1000+d18O_mw) 
# alpha_18O                                  
a_cell_3_mw_17<- exp(l_cell_mw*log(a_cell_3_mw_18))   
# alpha_17O


# Output # 
# Fractionation factors between fecal water and bw (body water) 
a_fec_bw_18<-1                                      
# alpha_18O
a_fec_bw_17<-1                                      
# alpha_17O

# Fractionation factors between urinary water and bw 
a_ur_bw_18<-1                                      
# alpha_18O
a_ur_bw_17<-1                                       
# alpha_17O

# Fractionation factors between nasal water vapor and bw
a_nas_bw_18<-1/alpha1((T+Body_T)/2)                 
# alpha_18O
l_nas_bw<-0.529                                     
# Fractionation exponent bewteen nasal water vapor and body water (Barkan & Luz 2005)
a_nas_bw_17<-exp(l_nas_bw*log(a_nas_bw_18))         
# alpha_17O

# Fractionation factors between transcutaneously-lost water vapor and bw
a_trans_bw_18<-1/1.018                              
# alpha_18O, Kohn (1996)
l_trans_bw<-0.5235                                  
# Fractionation exponent between transcutaneous water vapor loss and body water (Hu et al. 2023)
a_trans_bw_17<-exp(l_trans_bw*log(a_trans_bw_18))   
# alpha_17O

# Fractionation factors between exhaled CO2 and bw
frac_a_CO2_bw_18<-alpha2(Body_T)                    
# alpha_18O
l_CO2_bw<-0.5248                                    
# Fractionation exponent between CO2 and H2O (Cao & Liu 2010)
frac_a_CO2_bw_17<-exp(l_CO2_bw*log(frac_a_CO2_bw_18))    
# alpha_17O

# Non-Fractionating factors between exhaled CO2 and bw
unfrac_a_CO2_bw_18<-1                               
# alpha_18O
unfrac_a_CO2_bw_17<-1                             
# alpha_17O

# Fractionation factors between exhaled H2O and bw
a_brea_bw_18<-1/alpha1(Body_T)                      
# alpha_18O
l_brea_bw<-0.529;                                    
# Fractionation exponent between breath water vapor and body water (Barkan & Luz 2005)
a_brea_bw_17<-exp(l_brea_bw*log(a_brea_bw_18));  
# alpha_17O

# Calculations #

# Air O2 composition
d17O_atmO2<-(exp((D17O_atmO2+lamda*log(d18O_atmO2/1000+1)*1000)/1000)-1)*1000
# d17O of atmospheric O2 based on input information
R_18_atmO2<-((d18O_atmO2/1000)+1)*R_18_SMOW
# Calculated R_18O of atmospheric O2
R_17_atmO2<-((d17O_atmO2/1000)+1)*R_17_SMOW
# Calculated R_17O of atmospheric O2

# Meteoric H2O composition 
d17O_mw<-(exp((D17O_mw+lamda*log(d18O_mw/1000+1)*1000)/1000)-1)*1000
# d17O of meteoric water based on input information
R_18_mw<-((d18O_mw/1000)+1)*R_18_SMOW
# Calculated R_18O of meteoric H2O
R_17_mw<-((d17O_mw/1000)+1)*R_17_SMOW
# Calculated R_17O of meteoric H2O

# Food H2O composition
R_18_fooditem_1<-FoodItem_1_f*(((FoodItem_1_d18O/1000)+1)*R_18_SMOW);
# Calculated R_18O of Food Item 1 H2O
R_17_fooditem_1<-FoodItem_1_f*(((FoodItem_1_d17O/1000)+1)*R_17_SMOW);
# Calculated R_17O of Food Item 1 H2O
R_18_fooditem_2<-FoodItem_2_f*(((FoodItem_2_d18O/1000)+1)*R_18_SMOW);
# Calculated R_18O of Food Item 2 H2O
R_17_fooditem_2<-FoodItem_2_f*(((FoodItem_2_d17O/1000)+1)*R_17_SMOW);
# Calculated R_17O of Food Item 2 H2O
R_18_fooditem_3<-FoodItem_3_f*(((FoodItem_3_d18O/1000)+1)*R_18_SMOW);
# Calculated R_18O of Food Item 3 H2O
R_17_fooditem_3<-FoodItem_3_f*(((FoodItem_3_d17O/1000)+1)*R_17_SMOW);
# Calculated R_17O of Food Item 3 H2O
R_18_fooditem_4<-FoodItem_4_f*(((FoodItem_4_d18O/1000)+1)*R_18_SMOW);
# Calculated R_18O of Food Item 4 H2O
R_17_fooditem_4<-FoodItem_4_f*(((FoodItem_4_d17O/1000)+1)*R_17_SMOW);
# Calculated R_17O of Food Item 4 H2O
R_18_fooditem_5<-FoodItem_5_f*(((FoodItem_5_d18O/1000)+1)*R_18_SMOW);
# Calculated R_18O of Food Item 5 H2O
R_17_fooditem_5<-FoodItem_5_f*(((FoodItem_5_d17O/1000)+1)*R_17_SMOW);
# Calculated R_17O of Food Item 5 H2O

# Mass Balance Equation 

# 18R
# Input
R_18_in<-R_18_mw*(fvap*a_vap_mw_18+fdw*a_dw_mw_18+(ffo*Cellulose_1_f*a_cell_1_mw_18)+(ffo*Cellulose_2_f*a_cell_2_mw_18)+(ffo*Cellulose_3_f*a_cell_3_mw_18)+(fCO_in*((a_cell_3_mw_18+a_cell_2_mw_18+a_cell_1_mw_18)/3)));
# Oxygen_18 input term exclude atmospheric O2
R_18_inatm<-R_18_atmO2*fO2*a_in_O2_18;
# Oxygen_18 input term from atmospheric O2
R_18_Prey<-ffp*(R_18_fooditem_1+R_18_fooditem_2+R_18_fooditem_3+R_18_fooditem_4+R_18_fooditem_5)
# Oxygen_18 input term from prey items

# Output
r_18_out<-ffec*a_fec_bw_18+furO*a_ur_bw_18+fur*a_ur_bw_18+fnas*a_nas_bw_18+ftrans*a_trans_bw_18+foral*a_brea_bw_18+(fCO2*1*frac_a_CO2_bw_18)+(fCO2*0*unfrac_a_CO2_bw_18);
# Oxygen_18 Output term  

# 17R #
# Input
R_17_in<-R_17_mw*(fvap*a_vap_mw_17+fdw*a_dw_mw_17+(ffo*Cellulose_1_f*a_cell_1_mw_17)+(ffo*Cellulose_2_f*a_cell_2_mw_17)+(ffo*Cellulose_3_f*a_cell_3_mw_17)+(fCO_in*((a_cell_3_mw_17+a_cell_2_mw_17+a_cell_1_mw_17)/3)));
# Oxygen_17 input term exclude atmospheric O2
R_17_inatm<-R_17_atmO2*fO2*a_in_O2_17;
# Oxygen_17 input term from atmospheic O2
R_17_Prey<-ffp*(R_17_fooditem_1+R_17_fooditem_2+R_17_fooditem_3+R_17_fooditem_4+R_17_fooditem_5)
# Oxygen_17 input term from prey items

# Output
r_17_out<-ffec*a_fec_bw_17+furO*a_ur_bw_17+fur*a_ur_bw_17+fnas*a_nas_bw_17+ftrans*a_trans_bw_17+foral*a_brea_bw_17+(fCO2*1*frac_a_CO2_bw_17)+(fCO2*0*unfrac_a_CO2_bw_17);
# Oxygen_17 Output term 

#    Results   #

R_18_bw<-(R_18_in+R_18_inatm+R_18_Prey)/r_18_out;
# Oxygen_18 mass balance
R_17_bw<-(R_17_in+R_17_inatm+R_17_Prey)/r_17_out;
# Oxygen_17 mass balance

d18O_bw_i<-(R_18_bw/R_18_SMOW-1)*1000
# d18O of body water
d17O_bw_i<-(R_17_bw/R_17_SMOW-1)*1000
# d17O of body water
D17O_bw_i<-(log(d17O_bw_i/1000+1)-lamda*log(d18O_bw_i/1000+1))*1000
# D17O of body water

AnimalBodyWater<-function(R_18_bw,R_18_SMOW, R_17_bw, R_17_SMOW, d17O_bw_i, d18O_bw_i, lamda) {
  d18O_bw_i<-(R_18_bw/R_18_SMOW-1)*1000
  d17O_bw_i<-(R_17_bw/R_17_SMOW-1)*1000
  D17O_bw_i<-(log(d17O_bw_i/1000+1)-lamda*log(d18O_bw_i/1000+1))*1000
  print(paste("d18O_bw=",d18O_bw_i))
  print(paste("d17O_bw=",d17O_bw_i))
  print(paste("E17O=",D17O_bw_i))}

AnimalBodyWater(R_18_bw,R_18_SMOW, R_17_bw, R_17_SMOW, d17O_bw_i, d18O_bw_i, lamda)