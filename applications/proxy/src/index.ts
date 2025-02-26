import { clients, Empty } from '@metro-boulot-dodo/proto';
import Fastify from 'fastify';

const fastify = Fastify({
  logger: true
});

fastify.get('/api/stations', async () => {
  return (await clients.dataService.getStations(Empty).response).stations;
});

fastify.get('/api/canvas', async (req, reply) => {
  const buffer = (await clients.kruskalService.getFullTree(Empty).response)
    .data;
  reply.type('image/png').send(buffer);
});

fastify.get('/api/kruskal', async (req, reply) => {
  const buffer = (
    await clients.kruskalService.getMinimumSpanningTree(Empty).response
  ).data;
  reply.type('image/png').send(buffer);
});

fastify.get('/api/path/:start/:end', async req => {
  const stations = (await clients.dataService.getStations(Empty).response)
    .stations;

  // @ts-ignore
  const start = stations.find(s => s.num === Number(req.params.start));
  // @ts-ignore
  const end = stations.find(s => s.num === Number(req.params.end));

  if (!start || !end) {
    return { error: 'Start or end station not found.' };
  }

  return await clients.dijkstraService.getShortestPath({
    start,
    end
  }).response;
});

try {
  fastify.listen({ port: Number(process.env.PORT || 3000), host: '0.0.0.0' });
} catch (err) {
  fastify.log.error(err);
  process.exit(1);
}
