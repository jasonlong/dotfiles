import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

const COMMANDS = [
  "assimilate",
  "call",
  "cleanup",
  "contrib",
  "doctor",
  "forever",
  "help",
  "observe",
  "plan",
  "plugins",
  "project-install",
  // Do not register /resume: Pi has a built-in interactive command by that name.
  "retrospect",
  "user-install",
  "yolo",
] as const;

function toSkillPrompt(name: string, args: string): string {
  return `/skill:${name}${args ? ` ${args}` : ""}`;
}

export default function activate(pi: ExtensionAPI): void {
  const forwardBabysit = async (args: unknown) => {
    pi.sendUserMessage(toSkillPrompt("babysit", String(args ?? "").trim()));
  };

  pi.registerCommand("babysit", {
    description: "Load the Babysitter orchestration skill",
    handler: forwardBabysit,
  });

  pi.registerCommand("babysitter", {
    description: "Alias for /babysit",
    handler: forwardBabysit,
  });

  pi.registerCommand("babysitter:resume", {
    description: "Open the Babysitter resume skill (avoids Pi's built-in /resume)",
    handler: async (args: unknown) => {
      pi.sendUserMessage(toSkillPrompt("resume", String(args ?? "").trim()));
    },
  });

  for (const name of COMMANDS) {
    const forward = async (args: unknown) => {
      pi.sendUserMessage(toSkillPrompt(name, String(args ?? "").trim()));
    };

    pi.registerCommand(name, {
      description: `Open the Babysitter ${name} skill`,
      handler: forward,
    });

    pi.registerCommand(`babysitter:${name}`, {
      description: `Alias for /${name}`,
      handler: forward,
    });
  }
}
