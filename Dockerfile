FROM pandoc/core:latest-ubuntu

# Install required packages for Japanese PDF output
RUN apt-get -q --no-allow-insecure-repositories update \
    && DEBIAN_FRONTEND=noninteractive \
       apt-get install --assume-yes --no-install-recommends \
         texlive-lang-japanese \
         texlive-fonts-recommended \
         texlive-latex-extra \
         texlive-luatex \
         fonts-ipaexfont \
         fonts-ipaexfont-gothic \
         fonts-ipaexfont-mincho \
    && rm -rf /var/lib/apt/lists/* \
    && luaotfload-tool --update

# Create templates directory if it doesn't exist
RUN mkdir -p /usr/local/share/pandoc/templates

# # Add Japanese template
# COPY <<'EOT' /usr/local/share/pandoc/templates/default.latex
# \documentclass[a4paper,luatex,ja=standard]{ltjarticle}
# \usepackage{geometry}
# \usepackage{luatexja}
# \usepackage[ipaex]{luatexja-preset}
# \geometry{top=30mm, bottom=30mm, left=30mm, right=30mm}

# \begin{document}
# $body$
# \end{document}
# EOT

# Keep the original ENTRYPOINT
WORKDIR /data