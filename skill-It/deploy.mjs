import { fileURLToPath } from 'url';
import { dirname, join } from 'path';
import ghPages from 'gh-pages';

// Get the directory name of the current module
const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

ghPages.publish(join(__dirname, 'dist'), {
  branch: 'gh-pages',
  message: 'Deploy new build',
  user:
	{
		name: 'DevelSSN',
		email: 'shashankshantharamnayak@gmail.com',
	},
  repo: 'https://github.com/DevelSSN/skill-It.git',

}, (err) => {
  if (err) {
    console.error('Deployment failed', err);
  } else {
    console.log('Deployment successful');
  }
});
