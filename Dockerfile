FROM ubuntu:18.04

LABEL "com.github.actions.name"="ACTION: TYPO3 Documentation on Github"
LABEL "com.github.actions.description"="Build TYPO3 Documentation and trigger gh-pages deployment"
LABEL "com.github.actions.icon"="upload-cloud"
LABEL "com.github.actions.color"="orange"

LABEL "repository"="https://github.com/mai-space/action-typo3-documentation-on-github"
LABEL "homepage"="https://maispace.de"
LABEL "maintainer"="Joel Mai <joel@maispace.de>"

RUN apt-get update && apt-get install -y docker docker-compose

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]