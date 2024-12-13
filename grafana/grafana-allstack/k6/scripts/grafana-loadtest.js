import { group, check, sleep } from "k6";
import http from "k6/http";

// User think time in between page loads etc. (change this to 0 when debugging)
const thinkTime = 30;

export let options = {
        vus: 1,
        tags: {
          testid: 'loadtest',
        },
	thresholds: {
		'http_req_duration{kind:grafana}': ["avg<=10"],
		'http_reqs': ["rate>100"],
	}
};

export default function() {
	group("front page", function() {
		check(http.get("http://grafana:3000/", {
			tags: {'kind': 'grafana' },
		}), {
			"status is 200": (res) => res.status === 200,
		});
	});
        sleep(thinkTime);
}
