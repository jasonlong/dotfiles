-- CSS language server configuration
-- Ignore Tailwind's custom at-rules like @utility

return {
	settings = {
		css = {
			lint = {
				unknownAtRules = "ignore",
			},
		},
		scss = {
			lint = {
				unknownAtRules = "ignore",
			},
		},
		less = {
			lint = {
				unknownAtRules = "ignore",
			},
		},
	},
}
