<script lang="ts">
	import { onMount, onDestroy } from "svelte";

	import Nested from "../logo.svelte";
	import Form from "../form.svelte";

	const endpoint = "http://localhost:3000";

	let combined_hours: Array<Array<string>> = [];

	async function fetchData() {
		combined_hours = await fetch(endpoint + "/api/summary").then(
			(response) => response.json()
		);
	}

	const pollData = () => {
		setTimeout(() => {
			fetchData().then(() => pollData());
		}, 1000 * 10); // every 10s
	};

	onMount(() => {
		pollData();
	});

	onDestroy(() => {
		clearTimeout(pollData);
	});
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
		Work less without disclosing it to your employer
	</h1>

	<h4 class="text-center">a cost-effective action for climate</h4>

	<p>
		You decide how much less based on your risk tolerance and perception of
		your employer's contribution to the climate crisis. We suggest 30
		minutes a day to start (2.5h/w), and adjust to your liking on a month
		basis.
	</p>

	<p>
		Let us know how much you pledge so we can quantify our combined impact:
	</p>
	<Form />

	<p>
		<small>We only store information you provide in this form.</small>
	</p>

	<p>Why:</p>
	<ul>
		<li>
			<strong>improve your life</strong>: learn a new skill, more time
			with family or have fun with this time
		</li>
		<li>
			<strong>reduce CO2 emissions</strong>: it reduces economical output
			by a multiplier of your salary
		</li>
		<li>
			<strong>reduce inequality</strong>: it reduces the amount of value
			that your employer extracts from you
		</li>
		<li>
			<strong>impacts poluting companies the most</strong>: you better
			than any advertisment know how much your company is contributing to
			the climate crisis
		</li>
	</ul>

	<h2>Pledges around the world</h2>

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

	<footer>
		<p>Improve us on Github</p>
	</footer>
</main>
