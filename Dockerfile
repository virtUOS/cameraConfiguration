FROM python:3.13-slim as build
COPY . /occameracontrol

FROM python:3.13-slim
EXPOSE 8000
RUN --mount=type=bind,from=build,source=/occameracontrol,target=/occameracontrol \
    --mount=type=tmpfs,destination=/tmp \
    cp -r /occameracontrol /tmp \
    && pip install --no-cache-dir /tmp/occameracontrol \
    && cp /occameracontrol/camera-control.yml /etc/camera-control.yml

USER nobody
ENTRYPOINT [ "opencast-camera-control" ]
