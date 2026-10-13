# Collapses one `gh pr list --json ...` payload into one compact line per PR.
# Args: --arg me <github-login>  --arg repo <owner/name>
# Drops drafts and bot-authored PRs.

def ci:
  (.statusCheckRollup // []) as $r
  | if ($r|length) == 0 then "none"
    elif any($r[]; ((.conclusion // "") | test("FAILURE|TIMED_OUT|CANCELLED|ACTION_REQUIRED|STARTUP_FAILURE"))
                or ((.state // "") | test("FAILURE|ERROR"))) then "fail"
    elif any($r[]; ((.status // "COMPLETED") != "COMPLETED") or ((.state // "") == "PENDING")) then "pending"
    else "pass" end;

.[]
| select(.isDraft | not)
| select((.author.is_bot // false) | not)
| { repo: ($repo | sub("^.*/"; "")),
    num: .number,
    title: .title,
    author: .author.login,
    ci: ci,
    review: (.reviewDecision // "NONE"),
    age: (((now - (.createdAt | fromdate)) / 86400) | floor),
    conflict: ((.mergeable // "UNKNOWN") == "CONFLICTING"),
    mine: (.author.login == $me),
    assigned: ([ (.assignees // [])[].login ] | index($me) != null),
    requested: ([ (.reviewRequests // [])[].login // empty ] | index($me) != null),
    url: .url }
