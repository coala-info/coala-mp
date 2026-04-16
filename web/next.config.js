/** @type {import('next').NextConfig} */
// Must match the browser path where this app lives (leading slash, no trailing slash).
// Examples: `/mp` when the host serves this export at https://example.com/mp/;
// `/coala-mp/mp` for GitHub project Pages at https://<domain>/coala-mp/mp/ (repo + nested out/mp).
const basePath = process.env.COALA_MP_BASE_PATH || '/mp';
const nextConfig = {
  output: 'export',
  trailingSlash: true,
  basePath,
  assetPrefix: basePath.endsWith('/') ? basePath : `${basePath}/`,
  env: {
    NEXT_PUBLIC_BASE_PATH: basePath,
  },
};

module.exports = nextConfig;
