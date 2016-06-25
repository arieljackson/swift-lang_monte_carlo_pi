import "stdlib.v2";
type file;

# ------ INPUTS / OUTPUTS -------#

//int throws   = 5000;
int throws   = parseInt(arg("throws","30")); 
int nsims   = parseInt(arg("nsims", "100")); 
 
file out <"average.out">;
file pic <"pi.png">;
file mcpi_script	<"mcpi.py">;
file stats_script	<"stats.sh">;
file viz_script <"viz.py">;


# ------- APP DEFINITIONS -------#


app (file o) calc_pi (file pi_script, int num_throws)
{
  python filename(pi_script) num_throws stdout=filename(o);
}

app (file o) analyze (file stats_script, file s[])
{
  bash filename(stats_script) filenames(s) stdout=filename(o);
}

app (file o) visualize (file viz_script, float av, file s[])
{
  python filename(viz_script) av filenames(s);
}

# ----- WORKFLOW ELEMENTS ------#

file sims[];
float nums[];
float average;

foreach i in [0:nsims-1] { /* can change to nsims later */
  file simout <single_file_mapper; file=strcat("output/sim_",i,".out")>;
  simout = calc_pi(mcpi_script, throws);
  sims[i] = simout;
  nums[i] = read(sims[i]);
}

// iterate i {
//     result = strcat(nums[i], " ");
// } until (i == nsims);

average = avg(nums);
//out = analyze(stats_script,sims);
 out = write(average);
pic = visualize(viz_script, average, sims);