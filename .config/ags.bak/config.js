const entry = App.configDir + '/src/main.ts'
const outdir = '/tmp/ags/build'

try {
  await Utils.execAsync(['bun', 'build', entry, '--outdir', outdir, '--external', 'resource://*', '--external', 'gi://*']);
  await import(`file://${outdir}/main.js`);
} catch (err) {
  console.error(err);
}
