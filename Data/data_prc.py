import numpy as np
import pathlib
import os
import pandas as pd
import json
from scipy.interpolate import interp1d
from time import sleep

curr_path = pathlib.Path(__file__).parent
files = [curr_path/x for x in os.listdir(path= curr_path) if ".txt" in x]
flt = np.vectorize(float)
# print(files)



data = [0.]*len(files)
keys = [0.]*len(files)
# for i,file in enumerate(files):
with open(files[0], "r") as f:
    data[0] = f.readlines()[58:]
    for i in range(len(data[0])):
        data[0][i] = np.array(flt(data[0][i].split()))
    keys[0] = ["year", "month", "yearFrac", "monthly_average","de-season_alized","#days","st.dev_of_days","unc.of_mon_mean"]
    data[0] = np.array(data[0])
# with open(files[1], "r") as f:
#     data[1] = f.readlines()[48  :]
#     for i in range(len(data[1])):
#         data[1][i] = np.array(flt(data[1][i].split()))
#     keys[1] = ["year", "month", "Monthly_Anomaly", "Annual_Anomaly","Five-year_Anomaly","Ten-year_Anomaly","Twenty-year_Anomaly"]
#     data[1] = np.array(data[1])
with open(files[1], "r") as f:
    data[1] = f.readlines()[5:]
    # print(data[1][0])
    for i in range(len(data[1])):
        data[1][i] = np.array(flt(data[1][i].split()))
    keys[1] = ["year", "No_Smoothing", "Lowess"]
    data[1] = np.array(data[1])
    
with open(files[2], "r") as f:
    data[2] = f.readlines()[49:]
    for i in range(len(data[2])):
        data[2][i] = np.array(flt(data[2][i].split()))
    data[2] = np.array(data[2])
    keys[2] = ["altimeter type","merged file cycle","yearFrac","number of observations","number of weighted observations","GMSL (Global Isostatic Adjustment (GIA) NA) variation (mm)","std of GMSL (GIA NA) variation estimate (mm)","smoothed (60-day Gaussian type filter) GMSL (GIA NA) variation (mm)","GMSL (GIA applied) variation (mm)","std of GMSL (GIA applied) variation estimate (mm)","smoothed (60-day Gaussian type filter) GMSL (GIA applied) variation (mm)","smoothed (60-day Gaussian type filter) GMSL (GIA applied) variation (mm); annual and semi-annual signal removed"]




co2 = dict()
mnTemp = dict()
SeaLevel = dict()
for i,key in enumerate(keys[0]):
    co2[key] = data[0][:,i]
for i,key in enumerate(keys[1]):
    mnTemp[key] = data[1][:,i]
for i,key in enumerate(keys[2]):
    SeaLevel[key] = data[2][:,i]

def frac_year(year,month):
    return year+(month-1)/12.
    
# mnTemp["yearFrac"] = frac_year(mnTemp["year"], mnTemp["month"])

co2 = pd.DataFrame(co2)
mnTemp = pd.DataFrame(mnTemp)
SeaLevel = pd.DataFrame(SeaLevel)

year_cut = 1993
co2 = co2[co2['yearFrac'] > year_cut] 
mnTemp = mnTemp[mnTemp['year'] > year_cut] 
SeaLevel = SeaLevel[SeaLevel['yearFrac'] > year_cut] 
mnTemp["year"] = mnTemp["year"] + 0.5

# print(co2["yearFrac"])


"""Create the function with the time series"""

fCO2 = interp1d(co2["yearFrac"].to_numpy(),co2["de-season_alized"].to_numpy())
ftemp = interp1d(mnTemp["year"].to_numpy(),mnTemp["No_Smoothing"].to_numpy())
fSL = interp1d(SeaLevel["yearFrac"].to_numpy(),SeaLevel["smoothed (60-day Gaussian type filter) GMSL (GIA applied) variation (mm); annual and semi-annual signal removed"].to_numpy())

times = np.linspace(1995,2022,1000)

CO2_data = fCO2(times)
Temp_data = ftemp(times)
SeaLevel_data = fSL(times)

"""Building Extrapolation models"""
"""First, the interpolation ones"""
co2Temp_Interp = interp1d(CO2_data,Temp_data)
TempSL_Interp = interp1d(Temp_data,SeaLevel_data)

def extrap1d(interpolator):
    xs = interpolator.x
    ys = interpolator.y

    def pointwise(x):
        if x < xs[0]:
            return ys[0]+(x-xs[0])*(ys[1]-ys[0])/(xs[1]-xs[0])
        elif x > xs[-1]:
            return ys[-1]+(x-xs[-1])*(ys[-1]-ys[-2])/(xs[-1]-xs[-2])
        else:
            return interpolator(x)

    def ufunclike(xs):
        return np.array(list(map(pointwise, np.array(xs))))

    return ufunclike

co2_Temp = extrap1d(co2Temp_Interp)
Temp_SL = extrap1d(TempSL_Interp)

def CO2_SL(co2):
    temp = co2_Temp(co2)
    return Temp_SL(temp)
print(co2_Temp([700]))