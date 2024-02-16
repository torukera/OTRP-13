-- Minlevel and multiplier are MANDATORY
-- Maxlevel is OPTIONAL, but is considered infinite by default
-- Create a stage with minlevel 1 and no maxlevel to disable stages
experienceStages = {
	{
		minlevel = 1,
		maxlevel = 50,
		multiplier = 1,
	},
	{
		minlevel = 51,
		maxlevel = 100,
		multiplier = 2,
	},
	{
		minlevel = 101,
		maxlevel = 150,
		multiplier = 3,
	},
	{
		minlevel = 151,
		maxlevel = 200,
		multiplier = 4,
	},
	{
		minlevel = 201,
		multiplier = 5,
	},
}

skillsStages = {
	{
		minlevel = 10,
		multiplier = 10,
	},
}

magicLevelStages = {
	{
		minlevel = 0,
		multiplier = 10,
	},
}