<script lang="ts">
	import { onMount, onDestroy } from "svelte";
	import Discord from "svelte-bootstrap-icons/lib/Discord.svelte";
	import Twitter from "svelte-bootstrap-icons/lib/Twitter.svelte";

	import Nested from "../logo.svelte";
	import Form from "../form.svelte";
	import Benefits from "../benefits.svelte";

	import { PUBLIC_API_ENDPOINT } from "$env/static/public";

	let combined_hours: Array<Array<string>> = [];

	let latest: Array<Array<string>> = [];

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
		fetchData();
		poll_id = pollData();
	});

	onDestroy(() => {
		clearTimeout(poll_id);
	});
</script>

<svelte:head>
	<link
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
		rel="stylesheet"
		integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
		crossorigin="anonymous"
	/>
	<link
		href="https://fonts.googleapis.com/css?family=Sofia Sans"
		rel="stylesheet"
	/>
</svelte:head>

<main style:color="#084298" style:font-family="Sofia Sans">
	<nav
		class="navbar navbar-expand-lg navbar-light"
		style:background-color="#CFE2FF"
	>
		<div class="container-fluid">
			<div class="d-flex flex-grow-1">
				<span class="w-100 d-lg-none d-block">
					<!-- hidden spacer to center brand on mobile --></span
				>
				<span class="navbar-brand">Hours4Climate</span>
				<div class="w-100 text-right">
					<button
						class="navbar-toggler"
						type="button"
						data-bs-toggle="collapse"
						data-bs-target="#myNavbar7"
					>
						<span class="navbar-toggler-icon" />
					</button>
				</div>
			</div>
			<div
				class="collapse navbar-collapse flex-grow-1 text-right"
				id="myNavbar7"
			>
				<ul class="navbar-nav ms-auto flex-nowrap">
					<li class="nav-item">
						<a
							class="nav-link"
							href="https://twitter.com/hours4climate"
							title="Follow us on twitter"
						>
							<Twitter color="#1DA1F2" width={32} height={32} />
						</a>
					</li>
					<li class="nav-item">
						<a
							class="nav-link"
							href="https://discord.gg/FgcWVbypqU"
							title="Join us on Discord"
						>
							<Discord color="#7289da" width={32} height={32} />
						</a>
					</li>
				</ul>
			</div>
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
			<div class="row">
				<div class="col-md-6">
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
				</div>
				<div class="col-md-6">
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
				</div>
			</div>
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
		<p>
			<a
				href="https://medium.com/@climate_crisis_moderates/introduction-to-hours4climate-5371456ada93"
			>
				Blog post
			</a>
		</p>
	</footer>
</main>
