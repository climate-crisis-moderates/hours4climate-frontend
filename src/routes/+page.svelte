<script lang="ts">
	import { Col, Row } from "sveltestrap";
	import { onMount, onDestroy } from "svelte";
	import Discord from "svelte-bootstrap-icons/lib/Discord.svelte";

	import Nested from "../logo.svelte";
	import Form from "../form.svelte";
	import Benefits from "../benefits.svelte";

	import { PUBLIC_API_ENDPOINT } from "$env/static/public";

	let combined_hours: Array<Array<string>> = [
		["Canada", "1", "2"],
		["US", "2", "2"],
	];

	let latest: Array<Array<string>> = [
		["Canada", "1"],
		["US", "2"],
		["Canada", "1"],
		["US", "2"],
		["Canada", "1"],
	];

	async function fetchData() {
		combined_hours = await fetch(PUBLIC_API_ENDPOINT + "/api/summary").then(
			(response) => response.json()
		);
		latest = await fetch(PUBLIC_API_ENDPOINT + "/api/recent").then(
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
	<link
		href="https://fonts.googleapis.com/css?family=Sofia Sans"
		rel="stylesheet"
	/>
</svelte:head>

<main
	class="container-fluid px-0"
	style:color="#084298"
	style:font-family="Sofia Sans"
>
	<nav
		class="navbar navbar-expand-lg navbar-light"
		style:background-color="#CFE2FF"
	>
		<div class="container-fluid">
			<span class="navbar-brand">Hours4Climate</span>
			<a href="https://discord.gg/FgcWVbypqU" title="Join us on Discord">
				<Discord color="#7289da" width={32} height={32} />
			</a>
		</div>
	</nav>

	<section
		class="text-center"
		style:padding-bottom="2em"
		style:background-color="#CFE2FF"
	>
		<Nested class="img-responsive center-block text-center" />
		<h1>Work less without disclosing it</h1>
		<h4>cost-effective action to tackle the climate crisis</h4>
	</section>

	<section class="container" style:padding-top="2em">
		<h5 style:padding-bottom="1em" class="font-weight-bold">
			Pledge anonymously to quantify our combined impact:
		</h5>
		<Form />
	</section>

	<section class="container-fluid" style:background-color="#CFE2FF">
		<div
			class="container"
			style:padding-top="2em"
			style:padding-bottom="2em"
		>
			<Row>
				<Col class="col-6">
					<p>
						<strong>Time is your biggest asset</strong> - Work less without
						disclosing to your employer when you believe that they are
						not doing enough to address the climate crisis.
					</p>
					<p>
						Decide how much based on your risk tolerance and their
						behavior. We suggest 30 minutes a day (2.5 hours/week),
						and adjust on a monthly basis.
					</p>
				</Col>
				<Col class="col-6">
					<h5 class="font-weight-bold">Latest pledges</h5>
					<table
						class="table table-bordered rounded text-center table-sm"
					>
						<thead style:background="white" style:color="#084298">
							<tr style:border-color="white">
								<th style:border-color="#CFE2FF" scope="col"
									>Country</th
								>
								<th style:border-color="#CFE2FF" scope="col"
									>Hours/week</th
								>
							</tr>
						</thead>
						<tbody>
							{#each latest as country_hours}
								<tr
									style:border-color="#CFE2FF"
									style:color="#6489BE"
								>
									<td style:border-color="white"
										>{country_hours[0]}</td
									>
									<td style:border-color="white"
										>{country_hours[1]}</td
									>
								</tr>
							{/each}
						</tbody>
					</table>
				</Col>
			</Row>
		</div>
	</section>

	<Benefits />

	<section class="container" style:padding-top="2em">
		<h5 style:padding-bottom="1em" class="font-weight-bold">
			Pledges so far
		</h5>

		<table
			class="table table-bordered rounded text-center"
			style:border-color="#CFE2FF"
		>
			<thead
				style:background="#CFE2FF"
				style:color="#084298"
				style:border-color="#CFE2FF"
			>
				<tr style:border-color="#CFE2FF">
					<th style:border-color="#CFE2FF" scope="col">Country</th>
					<th style:border-color="#CFE2FF" scope="col">Hours/week</th>
					<th style:border-color="#CFE2FF" scope="col">Persons</th>
				</tr>
			</thead>
			<tbody>
				{#each combined_hours as country_hours}
					<tr style:border-color="#CFE2FF" style:color="#6489BE">
						<td style:border-color="#CFE2FF">{country_hours[0]}</td>
						<td style:border-color="#CFE2FF">{country_hours[1]}</td>
						<td style:border-color="#CFE2FF">{country_hours[2]}</td>
					</tr>
				{/each}
			</tbody>
		</table>
	</section>

	<footer style:padding="2em">
		<p>Copyright 2023 Hours4Climate</p>
	</footer>
</main>
