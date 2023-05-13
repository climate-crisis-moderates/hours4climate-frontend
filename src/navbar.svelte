<script>
    import Discord from "svelte-bootstrap-icons/lib/Discord.svelte";
    import Twitter from "svelte-bootstrap-icons/lib/Twitter.svelte";

    import Logo from "./logo.svelte";
    import MediumLogo from "./medium_logo.svelte";
</script>

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
    <div class="collapse navbar-collapse flex-grow-1 text-right" id="myNavbar7">
        <ul class="navbar-nav ms-auto flex-nowrap">
            <li class="nav-item">
                <a
                    class="nav-link"
                    href="https://medium.com/@climate_crisis_moderates/introduction-to-hours4climate-5371456ada93"
                    title="Check the blog post"
                >
                    <MediumLogo />
                </a>
            </li>
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
