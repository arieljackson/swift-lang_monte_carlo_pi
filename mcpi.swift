import "stdlib.v2";
type file;

# ------ INPUTS / OUTPUTS -------#

//int throws   = 5000;
int throws   = parseInt(arg("throws","5000")); 
int nsims   = parseInt(arg("nsims", "10")); 
 
file out 			<"average.out">;
file mcpi_script	<"mcpi.sh">;
file stats_script	<"stats.sh">;


# ------- APP DEFINITIONS -------#

app (file o) calc_pi (file pi_script, int num_throws)
{
  bash filename(pi_script) num_throws stdout=filename(o);
}

app (file o) analyze (file stats_script, file s[])
{
  bash filename(stats_script) filenames(s) stdout=filename(o);
}

# ----- WORKFLOW ELEMENTS ------#

file sims[];
float nums[];

foreach i in [0:nsims-1] { /* can change to nsims later */
  file simout <single_file_mapper; file=strcat("output/sim_",i,".out")>;
  simout = calc_pi(mcpi_script, throws);
  sims[i] = simout;
  nums[i] = read(sims[i]);
}

//out = analyze(stats_script,sims);
 out = write(avg(nums));