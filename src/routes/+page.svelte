<script lang="ts">
	import { onMount, onDestroy } from "svelte";
	import Discord from "svelte-bootstrap-icons/lib/Discord.svelte";

	import Nested from "../logo.svelte";
	import Form from "../form.svelte";
	import Benefits from "../benefits.svelte";

	import { PUBLIC_API_ENDPOINT } from "$env/static/public";

	let combined_hours: Array<Array<string>> = [];

	async function fetchData() {
		combined_hours = await fetch(PUBLIC_API_ENDPOINT + "/api/summary").then(
			(response) => response.json()
		);
	}

	const pollData = () => {
		return setTimeout(() => {
			fetchData().then(() => pollData());
		}, 1000 * 10); // every 10s
	};

	let poll_id: number = 0;
	onMount(() => {
		poll_id = pollData();
	});

	onDestroy(() => {
		clearTimeout(poll_id);
	});
</script>

<svelte:head>
	<link
		rel="stylesheet"
		href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	/>
</svelte:head>

<main class="container-fluid px-0">
	<nav class="navbar navbar-expand-lg navbar-light">
		<div class="container-fluid">
			<span class="navbar-brand">Hours4Climate</span>
			<a href="https://discord.gg/FgcWVbypqU" title="Join us on Discord">
				<Discord color="#7289da" width={32} height={32} />
			</a>
		</div>
	</nav>

	<section class="text-center" style:margin-bottom="4em">
		<Nested class="img-responsive center-block text-center" />
		<h1>Work less without disclosing it</h1>
		<h4>cost-effective action to tackle the climate crisis</h4>
		<p>
			Work less without disclosing to your employer when you believe that
			they are not doing enough to address the climate crisis.
		</p>
		<p>
			Decide how much based on your risk tolerance and their behavior. We
			suggest 30 minutes a day (2.5 hours/week), and adjust on a monthly
			basis.
		</p>
	</section>

	<Benefits />

	<section style:background="#2E9FD8" style:padding="2em">
		<h2 class="text-center">Pledge anonymously</h2>
		<p class="text-center">to quantify our combined impact</p>
		<Form />
	</section>

	<section style:background="#9AC7D9" style:padding="2em">
		<h2 class="text-center">Pledges so far</h2>

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
	</section>

	<footer style:padding="2em">
		<p>Copyright 2023 Hours4Climate</p>
	</footer>
</main>
