
type file;

# ------ INPUTS / OUTPUTS -------#

int throws   = 5000;
/* int throws   = toInt(arg("throws","5000")); */

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
  stats filenames(s) stdout=filename(o);
}

# ----- WORKFLOW ELEMENTS ------#

file sims[];

foreach i in [0:10] { /* can change to nsims later */
  file simout <single_file_mapper; file=strcat("/core/swift-lang_monte_carlo_pi/output/sim_",i,".out")>;
  simout = calc_pi(mcpi_script, throws);
  sims[i] = simout;
}

out = analyze(stats_script,sims);
