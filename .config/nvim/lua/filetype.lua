vim.filetype.add({
	filename = {
		JenkinsFile = "groovy",
		Jenkinsfile = "groovy",
		jenkinsfile = "groovy",
	},
	pattern = {
		[".*Jenkinsfile"] = "groovy",
	},
})
