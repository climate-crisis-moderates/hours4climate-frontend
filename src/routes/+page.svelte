<script lang="ts">
	import { onMount, onDestroy } from "svelte";
	import { Col, Row, FormGroup, Input } from "sveltestrap";
	import Select from "svelte-select";
	import HCaptcha from "svelte-hcaptcha";
	import Nested from "../logo.svelte";

	const endpoint = "http://localhost:3000";

	let countries: Array<string> = [];

	let combined_hours: Array<Array<string>> = [];

	async function fetchData() {
		combined_hours = await fetch(endpoint + "/api/summary").then(
			(response) => response.json()
		);
		console.log(combined_hours);
	}

	const pollData = () => {
		setTimeout(() => {
			fetchData().then(() => pollData());
		}, 1000 * 10);
	};

	onMount(() => {
		pollData();
	});

	onDestroy(() => {
		clearTimeout(pollData);
	});

	async function get_countries(text: string) {
		let base = endpoint + "/api/country";
		let url = text == "" ? base : base + "?name=" + text;

		countries = await fetch(url).then((response) => response.json());

		return countries;
	}

	let captcha: HCaptcha;

	const handleError = () => {
		captcha.reset();
	};
	let hcaptcha_key = "10000000-ffff-ffff-ffff-000000000001";
	// let hcaptcha_key = '8458f785-ae1a-492f-b14f-3fdcac064c38';

	let token: string | null = null;
	let country: any = null;
	let hours: string | null = null;

	let isHuman = (event: any) => {
		token = event["detail"]["token"];
	};

	async function pedge() {
		return await fetch(endpoint + "/api/pledge", {
			method: "POST",
			body: JSON.stringify({
				token,
				country: country["value"],
				hours,
			}),
			headers: {
				Accept: "application/json",
				"Content-Type": "application/json",
			},
		}).catch((error) => {
			console.log(error);
		});
	}
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
	<h1 class="text-center">
		Work less without disclosing it to your employer, for climate
	</h1>

	<p>A cost-effective civil desobidence action that many can.</p>

	<p>
		You decide how much to act based on your risk tolerance, personal
		situation and your perception of your employer's contribution to the
		climate crisis.
	</p>

	<p>
		We suggest 30 minutes a day as a starting point, and adjust to your
		liking on a month basis.
	</p>

	<p>
		Let us know how much you are acting so we can quantify our combined
		impact:
	</p>

	<form on:submit|preventDefault={pedge} class="needs-validation">
		<Row>
			<Col>
				<Select
					placeholder="Country you work at"
					loadOptions={get_countries}
					bind:value={country}
					required
				/>
			</Col>
			<Col>
				<FormGroup>
					<Input
						type="number"
						placeholder="hours/week"
						min="0"
						max="10"
						step="0.1"
						bind:value={hours}
						required
					/>
				</FormGroup>
			</Col>
			<Col>
				<button
					disabled={token === null ||
						hours === null ||
						country === null}
					data-placement="top"
					title={token === null ? "Fill form" : ""}
					type="submit"
					class="btn btn-success"
					data-toggle="tooltip"
				>
					Pledge
				</button>
			</Col>
		</Row>
		<div class="text-center">
			<HCaptcha
				bind:this={captcha}
				sitekey={hcaptcha_key}
				on:success={isHuman}
				on:error={handleError}
			/>
		</div>
	</form>
	<p>
		<small>We only store information you provide in the form.</small>
	</p>

	<p>Why:</p>
	<ul>
		<li>
			your career is not negatively impacted if you leverage this free
			time for training / up-skill yourself
		</li>
		<li>
			<strong>decreases CO2 emissions</strong> by reducing economical output
		</li>
		<li>
			<strong>decreases inequality</strong> by reducing the amount of value
			that your employer extracts from you
		</li>
		<li>
			<strong>impacts poluting companies the most</strong> as employees know
			are contributing the most to the climate crisis
		</li>
	</ul>

	<table class="table">
		<thead>
			<tr>
				<th scope="col">Country</th>
				<th scope="col">Hours/week</th>
				<th scope="col">Persons</th>
			</tr>
		</thead>
		<tbody>
			{#each combined_hours as country_hours}
				<tr>
					<td>{country_hours[0]}</td>
					<td>{country_hours[1]}</td>
					<td>{country_hours[2]}</td>
				</tr>
			{/each}
		</tbody>
	</table>

	<div class="alert alert-warning" role="alert">
		TODO: show number of hours per country
	</div>
	<div class="alert alert-warning" role="alert">
		TODO: show total $ loss per month
	</div>

	<footer>
		<p>Improve us on Github</p>
	</footer>
</main>
