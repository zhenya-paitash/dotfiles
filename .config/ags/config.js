const { GLib } = imports.gi;
const entry = `${App.configDir}/src/main.ts`;
const outdir = GLib.build_filenamev([GLib.get_user_cache_dir(), "ags", "user"]);

try {
  await Utils.execAsync(['bun', 'build', entry, '--outdir', outdir, '--external', 'resource://*', '--external', 'gi://*']);
  await import(`file://${outdir}/main.js`);
} catch (err) {
  console.error(err);
}

