const dev = {
  API_ENDPOINT_URL: 'http://localhost:4000/admin/api/v1',
}

const prod = {
  API_ENDPOINT_URL: 'http://localhost:4000/admin/api/v1',
}

const test = {
  API_ENDPOINT_URL: 'http://localhost:4000/admin/api/v1',
}

const getEnv = () => {
  switch (process.env.NODE_ENV) {
    case 'development':
      return dev
    case 'production':
      return prod
    case 'test':
      return test
    default:
      break
  }
}

export const env = getEnv()
