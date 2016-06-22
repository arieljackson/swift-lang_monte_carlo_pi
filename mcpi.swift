type file;

# ------ INPUTS / OUTPUTS -------#

int throws   = toInt(arg("throws","5000"));

file out 			<"average.out">;
file mcpi_script	<"mcpi.sh">;
file stats_script	<"stats.sh">;


# ------- APP DEFINITIONS -------#

app (file o) calc_pi (int num_throws)
{
    bash filename(mcpi_script) num_throws stdout=filename(o);
}

app (file o) analyze (file stats_script, file s[])
{
  bash filename(stats_script) filenames(s) stdout=filename(o);
}

# ----- WORKFLOW ELEMENTS ------#

file sims[];

foreach i in [0:10] { /* can change to nsims later */
  file simout <single_file_mapper; file=strcat("output/sim_",i,".out")>;
  simout = calc_pi(throws);
  sims[i] = simout;
}

stats = analyze(stats_script,sims);
