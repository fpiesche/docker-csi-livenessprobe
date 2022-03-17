FROM golang:1.18.0-alpine AS builder

RUN apk add --no-cache git make bash
ADD livenessprobe/ /livenessprobe/
WORKDIR /livenessprobe
RUN make

FROM scratch
LABEL maintainers="Florian Piesche <florian@yellowkeycard.net>"
LABEL description="Unmodified multi-arch builds of kubernetes-csi/livenessprobe"

COPY --from=builder /livenessprobe/bin/livenessprobe /livenessprobe
ENTRYPOINT ["/livenessprobe"]
