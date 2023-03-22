<script lang="ts">
	import { Button, Col, Row, FormGroup, Input } from 'sveltestrap';
	import Select from 'svelte-select';
	import HCaptcha from 'svelte-hcaptcha';

	async function coutries(text: string) {
		let url =
			text == ''
				? 'https://restcountries.com/v3.1/all/?fields=name'
				: 'https://restcountries.com/v3.1/name/' + text + '?fields=name';

		return await fetch(url)
			.then((response) => response.json())
			.then((data) => {
				return data.map((item: any) => item['name']['common']);
			});
	}
	import Nested from '../logo.svelte';

	let captcha: HCaptcha;

	const handleError = () => {
		captcha.reset();
	};
	let mySitekey = '8458f785-ae1a-492f-b14f-3fdcac064c38';

	const handleSuccess = () => {
		console.log('Success!');
	};
</script>

<svelte:head>
	<link
		rel="stylesheet"
		href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	/>
</svelte:head>

<main class="container">
	<div class="text-center">
		<Nested class="img-responsive center-block" />
	</div>
	<h1 class="text-center">hours4climate</h1>
	<h2 class="text-center">Work less without disclosing it to your employer, for climate</h2>

	<p>This page contains a civil desobidence action with a very high impact to cost ratio.</p>

	<p>Because:</p>
	<ul>
		<li>
			your career is not negatively impacted: leverage this free time for training / up-skill
			yourself
		</li>
		<li>it reduces CO2 emissions by reducing economical output</li>
		<li>
			it reduces inequality by reducing the amount of value that your employer extracts from you
		</li>
		<li>
			it impacts companies whose employees believe are contributing the most to the climate crisis
		</li>
	</ul>

	<p>
		You decide how much to act based on your risk tolerance, personal situation and your perception
		of your employer's contribution to the climate crisis.
	</p>
	<p>
		We suggest 30 minutes a day as a starting point, and adjust to your liking on a month basis.
	</p>

	<p>Let us know how much you are acting so we can quantify our combined impact:</p>

	<Row>
		<Col>
			<Select placeholder="Country you work at" loadOptions={coutries} />
		</Col>
		<Col>
			<FormGroup>
				<Input type="number" placeholder="hours/week" />
			</FormGroup>
		</Col>
		<Col>
			<Button color="success" outline>Pledge</Button>
		</Col>
	</Row>
	<p>
		<small>
			We do not track you. We do not store cookies. We only store the information provided in this
			form.
		</small>
	</p>
	<div class="text-center">
		<HCaptcha
			bind:this={captcha}
			sitekey={mySitekey}
			on:success={handleSuccess}
			on:error={handleError}
		/>
	</div>

	<div class="alert alert-warning" role="alert">TODO: show number of hours per country</div>
	<div class="alert alert-warning" role="alert">TODO: show total $ loss per month</div>

	<footer>
		<p>Improve us on Github</p>
	</footer>
</main>
<link rel="stylesheet" href="node_modules/svelte-material-ui/bare.css" />
