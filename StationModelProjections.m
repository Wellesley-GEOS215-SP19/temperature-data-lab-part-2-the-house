function [baseline_model, tempAnnMeanAnomaly, P, temp2006] = StationModelProjections(station_number)

% StationModelProjections Analyze modeled future temperature projections at individual stations
%===================================================================
%
% USAGE:  [baseline_model, tempAnnMeanAnomaly, P] = StationModelProjections(station_number) 
%
% DESCRIPTION:
%       Use the function StationModelProjections to loop over all observation stations to
%       extract the linear rate of temperature change over the 21st century at
%       each station.
%
% INPUT:
%    station_number: Number of the station from which to analyze historical temperature data
%    **Describe any other inputs you choose to include**
%
% OUTPUT:
%    baseline_model: [mean annual temperature over baseline period
%       (2006-2025); standard deviation of temperature over baseline period]
%    tempAnnMeanAnomaly: Annual mean temperature anomaly, as compared to
%       the 2006-2025 baseline period
%    P: slope and intercept for a linear fit to annual mean temperature
%       values over the full 21st century modeled period
%    temp2006: The annual mean temp for the year 2006 for the input station
%   **list any other outputs you choose to include**
%
% AUTHOR:   KDLTP, NBB, GracieCal, 12 February 2019
%
% REFERENCE:
%    Written for GEOS 215: Earth System Data Science, Wellesley College
%    Data are from the a global climate model developed by the NOAA
%       Geophysical Fluid Dynamics Laboratory (GFDL) in Princeton, NJ - output
%       from the A2 scenario extracted by Sarah Purkey for the University of
%       Washington's Program on Climate Change
%==================================================================

%% Read and extract the data from your station from the csv file
%before running, set station_number = to any x in command window to avoid
%an error
filename = ['model' num2str(station_number) '.csv'];
%Extract the year and annual mean temperature data
stationdata = readtable(filename);
yearlist = stationdata.Year;
annualMeanList = stationdata.AnnualMeanTemperature;
temp2006 = annualMeanList(1)
%NBB- added temp2006 because it is useful to calculate the year of the
%signal emergence

%% Calculate the mean and standard deviation of the annual mean temperatures
%  over the baseline period over the first 20 years of the modeled 21st
%  century (2006-2025) - if you follow the template for output values I
%  provided above, you will want to combine these together into an array
%  with both values called baseline_model
 %<-- (this will take multiple lines of code - see the procedure you
 %followed last week for a reminder of how you can do this)


 
%Calculate the annual mean temperature over the period from 2006-2025
  %Use the find function to find rows contain data where stationdata.Year
  %is between 2006 and 2025
ind_baseline = find(yearlist <= 2025 & yearlist >= 2006);
  %Now calculate the mean over the full time period from 2006-2025
baseline_mean = mean(annualMeanList(ind_baseline));
baseline_std = std(annualMeanList(ind_baseline));

baseline_model = [baseline_mean,baseline_std]
 
%% Calculate the 5-year moving mean smoothed annual mean temperature anomaly over the modeled period
 %<-- anomaly
 tempAnnMeanAnomaly = annualMeanList-baseline_mean ;
 
 %<-- smoothed anomaly
fiveMean = movmean(tempAnnMeanAnomaly,5);
%comment from NBB- I changed these last two equations to match the 
%names of the output variables. We aren't currently using this smooth mean
%in any way 
%% Calculate the linear trend in temperature this station over the modeled 21st century period
 %<--
 P = polyfit(yearlist,tempAnnMeanAnomaly,1)
end