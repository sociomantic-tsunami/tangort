FROM ubuntu
COPY *.sh ./
RUN ./base.sh
RUN ./dmd.sh 2.071.2-0
RUN ./dmd1.sh v1.078.0
RUN rm *.sh
