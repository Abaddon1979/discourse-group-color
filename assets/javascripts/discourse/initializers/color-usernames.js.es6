// discourse-group-color/assets/javascripts/discourse/initializers/color-usernames.js.es6

import { ajax } from 'discourse/lib/ajax';
import { withPluginApi } from 'discourse/lib/plugin-api';

export default {
  name: "apply-username-colors",
  initialize(container) {
    withPluginApi("0.8.31", api => {
      if (!api.getCurrentUser()) {
        return;
      }

      function fetchGroupColors() {
        return ajax('/groups.json').then((data) => {
          const groupColors = {};

          data.groups.forEach((group) => {
            if (group.name && group.color && group.rank !== undefined) {
              groupColors[group.name] = {
                color: group.color,
                rank: group.rank,
              };
            }
          });

          return groupColors;
        });
      }

      function applyUsernameColors(groupColors) {
        document.querySelectorAll('.username').forEach((elem) => {
          const username = elem.dataset.username || elem.innerText.trim();

          ajax(`/u/${username}.json`)
            .then((userData) => {
              const userGroups = userData.user.groups;
              let lowestRank = Infinity;
              let selectedColor = null;

              userGroups.forEach((group) => {
                const groupColorInfo = groupColors[group.name];
                if (groupColorInfo && groupColorInfo.rank < lowestRank) {
                  lowestRank = groupColorInfo.rank;
                  selectedColor = groupColorInfo.color;
                }
              });

              if (selectedColor) {
                elem.style.color = selectedColor;
              }
            })
            .catch((e) => {
              console.error('Failed to fetch user data:', e);
            });
        });
      }

      function updateUsernameColors() {
        fetchGroupColors()
          .then((groupColors) => {
            applyUsernameColors(groupColors);
          })
          .catch((e) => {
            console.error('Failed to fetch group colors:', e);
          });
      }

      // Apply colors on page change
      api.onPageChange(() => {
        updateUsernameColors();
      });

      // Initial application
      updateUsernameColors();
    });
  }
};