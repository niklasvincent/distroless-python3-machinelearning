FROM python:3.5-jessie

ENV PYTHONUNBUFFERED 1

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libatlas-base-dev gfortran

COPY requirements.txt /

RUN pip install --no-cache-dir -r /requirements.txt

FROM gcr.io/distroless/python3

# Copy libatlas-base-dev files
COPY --from=0 /usr/lib/atlas-base /usr/lib/atlas-base
COPY --from=0 /usr/lib/libatlas.a /usr/lib/libatlas.a
COPY --from=0 /usr/lib/libatlas.so /usr/lib/libatlas.so
COPY --from=0 /usr/lib/libcblas.a /usr/lib/libcblas.a
COPY --from=0 /usr/lib/libcblas.so /usr/lib/libcblas.so
COPY --from=0 /usr/lib/libf77blas.a /usr/lib/libf77blas.a
COPY --from=0 /usr/lib/libf77blas.so /usr/lib/libf77blas.so
COPY --from=0 /usr/lib/liblapack_atlas.a /usr/lib/liblapack_atlas.a
COPY --from=0 /usr/lib/liblapack_atlas.so /usr/lib/liblapack_atlas.so

# Copy gfortran files
COPY --from=0 /usr/bin/x86_64-linux-gnu-gfortran /usr/bin/x86_64-linux-gnu-gfortran
COPY --from=0 /usr/bin/gfortran /usr/bin/gfortran

# Copy Python packages
COPY --from=0 /usr/local/lib/python3.5/site-packages/sklearn /usr/lib/python3.5/sklearn
COPY --from=0 /usr/local/lib/python3.5/site-packages/pandas /usr/lib/python3.5/pandas
COPY --from=0 /usr/local/lib/python3.5/site-packages/numpy /usr/lib/python3.5/numpy
COPY --from=0 /usr/local/lib/python3.5/site-packages/matplotlib /usr/lib/python3.5/matplotlib
COPY --from=0 /usr/local/lib/python3.5/site-packages/pytz /usr/lib/python3.5/pytz
COPY --from=0 /usr/local/lib/python3.5/site-packages/dateutil /usr/lib/python3.5/dateutil
COPY --from=0 /usr/local/lib/python3.5/site-packages/scipy /usr/lib/python3.5/scipy
COPY --from=0 /usr/local/lib/python3.5/site-packages/cycler.py /usr/lib/python3.5/cycler.py
COPY --from=0 /usr/local/lib/python3.5/site-packages/pyparsing.py /usr/lib/python3.5/pyparsing.py
COPY --from=0 /usr/local/lib/python3.5/site-packages/six.py /usr/lib/python3.5/six.py

