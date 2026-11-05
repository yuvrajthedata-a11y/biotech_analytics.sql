USE biotech_analytics_practice;
select * from assay_results;
select * from assays;
select * from biomarker_results;
select * from biomarkers;
select * from dq_issues;
select * from experiments;
select * from labs;
select * from method_qualification;
select * from programs;
select * from quality_events;
select * from stability_results;
select * from studies;

#Based on Study status show the total number of programs in each status 

Select studies.study_status, programs.program_code
FROM studies 
JOIN programs ON programs.program_id = studies.program_id
Where studies.study_status = "Completed";

#Retrieve all assays under the 'Potency' category along with their unit, lower specification limit (spec_low), and upper specification limit (spec_high).
SELECT assay_name, canonical_unit, assay_category, spec_low, spec_high 
FROM assays
WHERE assay_category = "Potency";

#List all experiments in study 'S001' where the viability percentage (viability_pct) was less than 85%, ordered by run_date descending.
SELECT experiment_id, assay_platform, viability_pct, run_date
FROM experiments
WHERE viability_pct < 85
ORDER BY run_date DESC
LIMIT 7
OFFSET 3;

#Out-of-Specification (OOS) Lot Rate: Join assay_results with programs and calculate the total number of lot releases tested versus the count of 'OOS' results per program. Order by the OOS count descending.
SELECT programs.program_id, COUNT(assay_results.result_id), SUM(CASE WHEN assay_results.result_status = "OOS" Then 1 else 0 END) as OOS_results
FROM programs
JOIN assay_results ON programs.program_id = assay_results.program_id
GROUP BY program_id
ORDER BY OOS_results DESC
LIMIT 5 
OFFSET 2;

#Stability Trend Outliers:Identify all records in stability_results under the -20C storage condition where an Out of Trend (oot_flag = 'Y') or Out of Specification (oos_flag = 'Y') occurred. Display lot_id, assay_id, timepoint_month, baseline_value, result_value, and percent_change.





