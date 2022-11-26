# Relatório
Iniciando o jogo, temos uma requisição HTTPS código 101 (Switching Protocol) que se mantém aberta e faz a troca para o protocolo HTTPS para WSS. 

## Sinalização
- Quando um jogador abre o jogo, o registro (Socket.IO) gera um identificador único (sid):

```json
{
	"GET": {
		"scheme": "wss",
		"host": "hidden-brook-30522.herokuapp.com",
		"filename": "/socket.io/",
		"query": {
			"EIO": "4",
			"transport": "websocket",
			"sid": "PuU5tDI943MzEOh8AAAA"
		},
		"remote": {
			"Endereço": "34.201.81.34:443"
		}
	}
}
```

- E ao clicar em uma sala de jogo a notificação de presença é marcada pelo envio da tag “entrar-na-sala”:

```json
{
	"type": 4,
	"nsp": "/",
	"id": 2,
	"data": [
		"entrar-na-sala",
		"0"
	]
}
```

- Quando um segundo entra no jogo, também ganha um identificador único:

```json
{
	"GET": {
		"scheme": "wss",
		"host": "hidden-brook-30522.herokuapp.com",
		"filename": "/socket.io/",
		"query": {
			"EIO": "4",
			"transport": "websocket",
			"sid": "LvSj1HV4sjOcvjdTAAAC"
		},
		"remote": {
			"Endereço": "34.201.81.34:443"
		}
	}
}
```
- E ao entrar em uma sala, notifica a presença com a tag “entrar-na-sala”:

```json
{
	"type": 4,
	"nsp": "/",
	"id": 2,
	"data": [
		"entrar-na-sala",
		"0"
	]
}
```

- Quando o segundo jogador entra na sala, este inicia a sinalização de mídia e oferta a lista de codecs suportados, enviando uma requisição ao outro agente.

## Estabelecimento de sessão de mídia

### Convite para sessão de mídia
- Aqui temos a requisição de oferta de mídia (offer):

```json
{
	"type": 4,
	"nsp": "/",
	"id": 2,
	"data": [
		"offer",
		"0",
		{
			"type": "offer",
			"sdp": "v=0\r\no=mozilla...THIS_IS_SDPARTA-99.0 8218895876101434947 0 IN IP4 0.0.0.0\r\ns=-\r\nt=0 0\r\na=sendrecv\r\na=fingerprint:sha-256 F9:3F:DA:FE:28:D9:6F:78:1F:7A:B0:90:BF:0D:0C:A6:28:A3:B8:4B:62:D2:8D:87:7C:D5:19:08:BE:47:27:49\r\na=group:BUNDLE 0\r\na=ice-options:trickle\r\na=msid-semantic:WMS *\r\nm=audio 9 UDP/TLS/RTP/SAVPF 109 9 0 8 101\r\nc=IN IP4 0.0.0.0\r\na=sendrecv\r\na=extmap:1 urn:ietf:params:rtp-hdrext:ssrc-audio-level\r\na=extmap:2/recvonly urn:ietf:params:rtp-hdrext:csrc-audio-level\r\na=extmap:3 urn:ietf:params:rtp-hdrext:sdes:mid\r\na=fmtp:109 maxplaybackrate=48000;stereo=1;useinbandfec=1\r\na=fmtp:101 0-15\r\na=ice-pwd:c2f04ca7a1db1f58cdde12c33a560b0a\r\na=ice-ufrag:2174c31c\r\na=mid:0\r\na=msid:{18cf902d-9bf4-4a39-9eb3-f0b52627116e} {bba8b1ff-0be8-4b63-b0f2-8a7c128a023b}\r\na=rtcp-mux\r\na=rtpmap:109 opus/48000/2\r\na=rtpmap:9 G722/8000/1\r\na=rtpmap:0 PCMU/8000\r\na=rtpmap:8 PCMA/8000\r\na=rtpmap:101 telephone-event/8000\r\na=setup:actpass\r\na=ssrc:1687021030 cname:{38825e36-5f4f-4afe-a964-e58794b216e5}\r\n"
		}
	]
}
```

- A seguir, a resposta com confirmação do outro agente (answer):

```json
{
	"type": 4,
	"nsp": "/",
	"id": 2,
	"data": [
		"answer",
		"0-CdB1R8p0ee8q_sAAAD",
		{
			"type": "answer",
			"sdp": "v=0\r\no=mozilla...THIS_IS_SDPARTA-99.0 6008960483522051358 0 IN IP4 0.0.0.0\r\ns=-\r\nt=0 0\r\na=sendrecv\r\na=fingerprint:sha-256 1D:C3:CA:97:81:13:DC:E1:15:0A:5F:60:26:95:0E:58:AD:7F:4B:94:C3:BB:EA:B4:73:EA:BA:2A:1C:77:81:A1\r\na=group:BUNDLE 0\r\na=ice-options:trickle\r\na=msid-semantic:WMS *\r\nm=audio 9 UDP/TLS/RTP/SAVPF 109 9 0 8 101\r\nc=IN IP4 0.0.0.0\r\na=sendrecv\r\na=extmap:1 urn:ietf:params:rtp-hdrext:ssrc-audio-level\r\na=extmap:3 urn:ietf:params:rtp-hdrext:sdes:mid\r\na=fmtp:109 maxplaybackrate=48000;stereo=1;useinbandfec=1\r\na=fmtp:101 0-15\r\na=ice-pwd:04e908c48b84f90ca9b19606cca44eb3\r\na=ice-ufrag:7afa0437\r\na=mid:0\r\na=msid:{d2d1ea89-0584-4f90-935b-e0d2739cd1c5} {004fbba5-64d1-488f-ae31-c76284d93027}\r\na=rtcp-mux\r\na=rtpmap:109 opus/48000/2\r\na=rtpmap:9 G722/8000/1\r\na=rtpmap:0 PCMU/8000\r\na=rtpmap:8 PCMA/8000\r\na=rtpmap:101 telephone-event/8000\r\na=setup:active\r\na=ssrc:3026363813 cname:{ef46a6fa-5a00-498c-b60e-3e1c1907d1b9}\r\n"
		}
	]
}
```

### Negociação de mídia
- Na requisição feita pelo agente A (8218895876101434947), o campo SDP referente a descrição de mídia, nome e endereço (m) informa que o tipo de mídia é áudio, 
a porta 9 (porta fictícia ICE) sobre UDP e a lista de codecs suportados: 
OPUS tipo 109, G.722 tipo 9, PCMU - G.711 lei μ tipo 0, PCMA - G.711 lei A tipo 8 e DTMF tipo 101, todos sendo sobre TLS/RTP/SAVPF. 

```sdp
v=0
o=mozilla...THIS_IS_SDPARTA-99.0 8218895876101434947 0 IN IP4 0.0.0.0
s=-
t=0 0
a=sendrecv
a=fingerprint:sha-256 F9:3F:DA:FE:28:D9:6F:78:1F:7A:B0:90:BF:0D:0C:A6:28:A3:B8:4B:62:D2:8D:87:7C:D5:19:08:BE:47:27:49
a=group:BUNDLE 0
a=ice-options:trickle
a=msid-semantic:WMS *
m=audio 9 UDP/TLS/RTP/SAVPF 109 9 0 8 101
c=IN IP4 0.0.0.0
a=sendrecv
a=extmap:1 urn:ietf:params:rtp-hdrext:ssrc-audio-level
a=extmap:2/recvonly urn:ietf:params:rtp-hdrext:csrc-audio-level
a=extmap:3 urn:ietf:params:rtp-hdrext:sdes:mid
a=fmtp:109 maxplaybackrate=48000;stereo=1;useinbandfec=1
a=fmtp:101 0-15
a=ice-pwd:c2f04ca7a1db1f58cdde12c33a560b0a
a=ice-ufrag:2174c31c
a=mid:0
a=msid:{18cf902d-9bf4-4a39-9eb3-f0b52627116e} {bba8b1ff-0be8-4b63-b0f2-8a7c128a023b}
a=rtcp-mux
a=rtpmap:109 opus/48000/2
a=rtpmap:9 G722/8000/1
a=rtpmap:0 PCMU/8000
a=rtpmap:8 PCMA/8000
a=rtpmap:101 telephone-event/8000
a=setup:actpass
a=ssrc:1687021030 cname:{38825e36-5f4f-4afe-a964-e58794b216e5}
```

- A confirmação por parte do agente B (6008960483522051358) retorna como tipo de mídia (m) áudio na porta 9/UDP e suporte a todos os codecs ofertados: 
OPUS tipo 109, G.722 tipo 9, PCMU - G.711 lei μ tipo 0, PCMA - G.711 lei A tipo 8 e DTMF tipo 101, todos sendo sobre TLS/RTP/SAVPF.

```sdp
v=0
o=mozilla...THIS_IS_SDPARTA-99.0 6008960483522051358 0 IN IP4 0.0.0.0
s=-
t=0 0
a=sendrecv
a=fingerprint:sha-256 1D:C3:CA:97:81:13:DC:E1:15:0A:5F:60:26:95:0E:58:AD:7F:4B:94:C3:BB:EA:B4:73:EA:BA:2A:1C:77:81:A1
a=group:BUNDLE 0
a=ice-options:trickle
a=msid-semantic:WMS *
m=audio 9 UDP/TLS/RTP/SAVPF 109 9 0 8 101
c=IN IP4 0.0.0.0
a=sendrecv
a=extmap:1 urn:ietf:params:rtp-hdrext:ssrc-audio-level
a=extmap:3 urn:ietf:params:rtp-hdrext:sdes:mid
a=fmtp:109 maxplaybackrate=48000;stereo=1;useinbandfec=1
a=fmtp:101 0-15
a=ice-pwd:04e908c48b84f90ca9b19606cca44eb3
a=ice-ufrag:7afa0437
a=mid:0
a=msid:{d2d1ea89-0584-4f90-935b-e0d2739cd1c5} {004fbba5-64d1-488f-ae31-c76284d93027}
a=rtcp-mux
a=rtpmap:109 opus/48000/2
a=rtpmap:9 G722/8000/1
a=rtpmap:0 PCMU/8000
a=rtpmap:8 PCMA/8000
a=rtpmap:101 telephone-event/8000
a=setup:active
a=ssrc:3026363813 cname:{ef46a6fa-5a00-498c-b60e-3e1c1907d1b9}
```
- Como houve a confirmação da requisição por parte do agente B, então o áudio no sentido A para B, foi confirmado. 
Com a requisição ACK o agente A aceita o áudio no sentido contrário, B para A.

## Codecs
Os codecs ofertados seguiram a RFC 3551 (seções 4.5.14 e 6), e foram aceitos por ambos agentes:

- De A para B: OPUS tipo 109, G.722 tipo 9, PCMU - G.711 lei μ tipo 0, PCMA - G.711 lei A tipo 8 e DTMF tipo 101, todos sendo sobre TLS/RTP/SAVPF.
- De B para A: OPUS tipo 109, G.722 tipo 9, PCMU - G.711 lei μ tipo 0, PCMA - G.711 lei A tipo 8 e DTMF tipo 101, todos sendo sobre TLS/RTP/SAVPF.
